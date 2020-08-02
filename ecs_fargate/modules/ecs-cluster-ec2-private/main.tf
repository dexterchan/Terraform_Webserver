

resource "aws_ecs_cluster" "main" {
    name = var.ecs_cluster_name
    /* add capacity providers if needed
    capacity_providers
    */
}
