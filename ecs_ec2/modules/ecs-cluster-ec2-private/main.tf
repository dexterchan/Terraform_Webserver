

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
  /* add capacity providers if needed
    capacity_providers
    */
}

/*
module "ecs-launch_config" {
  source     = "../launch-config"
  ec2_ami = data.aws_ami.amazon_linux_ecs.id
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
  desired_capacity          = var.desired_instances
  wait_for_capacity_timeout = 0

  target_group_arns = module.alb.target_group_arns

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    }
    /*
    ,{
      key                 = "AmazonECSManaged"
      propagate_at_launch = true
    }*/
  ]
}
/*
resource "aws_ecs_capacity_provider" "autoscale" {
  name = "autoscale"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = module.ecs-asg.this_autoscaling_group_arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 500
    }
  }
}*/
