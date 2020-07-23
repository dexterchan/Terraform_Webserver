


resource "aws_ecs_task_definition" "marketsvc-http" {
    family = "marketsvc-http"
    container_definitions = file("task-definitions/marketservice.json")
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