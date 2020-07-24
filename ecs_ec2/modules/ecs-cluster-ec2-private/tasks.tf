
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

resource "aws_ecs_task_definition" "marketsvc-http" {
    family = "marketsvc-http"
    container_definitions = data.template_file.container_task_config.rendered

    depends_on = [
    aws_cloudwatch_log_group.applog,
    ]
}


resource "aws_ecs_service" "marketsvc-http" {
    name = "marketsvc-http"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.marketsvc-http.arn
    iam_role = aws_iam_role.ecs_terraform_service_role.arn
    desired_count = 2
    

    load_balancer {
        target_group_arn = module.alb.target_group_arns[0]
        container_name = "marketsvc-http"
        container_port = 3000
    }
}