
resource "aws_cloudwatch_log_group" "applog" {
  name = "/ecs/terraform-svc/${var.ecs_cluster_name}"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Application = "${var.ecs_cluster_name}"
  }
}


data "template_file" "container_task_config" {
  template = file("task-definitions/webappsvc.json")

  vars = {
    region = var.region
    task_docker_image = var.task_docker_image
    log_grp = "/ecs/terraform-svc/${var.ecs_cluster_name}"
  }
}
#https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
resource "aws_ecs_task_definition" "marketsvc-http" {
  family                   = "marketsvc-http-staging"
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_app_execution_role.arn
  execution_role_arn = aws_iam_role.ecs_terraform_taskexecution_role.arn
  cpu                      = 256
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions = data.template_file.container_task_config.rendered
  tags = {
    Environment = "staging"
    Application = "dummyapi"
  }
  depends_on = [
    aws_cloudwatch_log_group.applog,
    ]
}


resource "aws_ecs_service" "marketsvc-http" {
    name = "marketsvc-http-svc"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.marketsvc-http.arn
    #InvalidParameterException: You cannot specify an IAM role for services that require a service linked role
    #iam_role = aws_iam_role.ecs_terraform_service_role.arn
    desired_count = 2
    launch_type     = "FARGATE"

    load_balancer {
        target_group_arn = aws_lb_target_group.fargate.arn
        container_name = "marketsvc-http"
        container_port = 3000
    }

    network_configuration {
      security_groups  = var.launch_config_security_group
      subnets          = var.asg_subnets
      assign_public_ip = false
    }
    depends_on = [
      aws_vpc_endpoint.cloudwatch,
      aws_vpc_endpoint.ecs-agent,
      aws_vpc_endpoint.ecs-telemetry,
      aws_vpc_endpoint.ecs,
      aws_vpc_endpoint.ecr_dkr,
      aws_vpc_endpoint.ecr_api,
      aws_vpc_endpoint.s3
    ]
}