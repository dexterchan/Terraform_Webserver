

resource "aws_ecs_cluster" "main" {
    name = var.ecs_cluster_name
    /* add capacity providers if needed
    capacity_providers
    */
}


module "ecs-launch_config" {
  source     = "../launch-config"
  webapp_ami = var.webapp_ami
  vpc_sg_ids = var.vpc_sg_ids
  aws_iam_instance_profile = aws_iam_instance_profile.ecs_terraform_profile.name
  vpc_id               = var.vpc_id
  key_name = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  ecs_cluster_name = var.ecs_cluster_name
}