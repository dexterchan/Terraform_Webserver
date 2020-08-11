

resource "aws_ecs_cluster" "main" {
    name = var.ecs_cluster_name
    /* add capacity providers if needed
    capacity_providers
    */
    capacity_providers = ["FARGATE", "FARGATE_SPOT"]
    default_capacity_provider_strategy {
        capacity_provider = "FARGATE_SPOT"
    }
}
