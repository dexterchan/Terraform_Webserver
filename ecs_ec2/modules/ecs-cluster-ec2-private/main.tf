

resource "aws_ecs_cluster" "main" {
    name = var.ecs_cluster_name
    /* add capacity providers if needed
    capacity_providers
    */
}

/*
module "ecs-launch_config" {
  source     = "../launch-config"
  webapp_ami = data.aws_ami.amazon_linux_ecs.id
  vpc_sg_ids = var.launch_config_security_group
  aws_iam_instance_profile = aws_iam_instance_profile.ecs_terraform_profile.name
  vpc_id               = var.vpc_id
  key_name = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  ecs_cluster_name = var.ecs_cluster_name
}
*/

module "ecs-asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "ECS-${var.ecs_cluster_name}"

  # Launch configuration
  #
  launch_configuration = aws_launch_configuration.as_conf.name
  create_lc            = false

  # Auto scaling group
  asg_name                  = "ECS-${var.ecs_cluster_name}"
  vpc_zone_identifier       = var.asg_subnets
  health_check_type         = "EC2"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0

  target_group_arns = module.alb.target_group_arns
  
  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    }
  ]

}
