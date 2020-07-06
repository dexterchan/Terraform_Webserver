


module "webapp-launch_config" {
  source     = "./modules/launch-config"
  webapp_ami = var.webapp_ami
  vpc_sg_ids = [aws_security_group.web-app.id,
  aws_security_group.bastion_ssh_private.id]
  iamrole              = var.webapp_IAM_ROLE
  vpc_id               = module.vpc.vpc_id
  subnets_vpc_endpoint = module.vpc.private_subnets
  vpc_sg_private_ids = [
    aws_security_group.vpc-private-conn.id,
  ]
}

module "privatewebgrp_asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "privateweb-grp"

  # Launch configuration
  #
  launch_configuration = module.webapp-launch_config.asgname
  create_lc            = false

  # Auto scaling group
  asg_name                  = "privateweb-asg"
  vpc_zone_identifier       = module.vpc.private_subnets
  health_check_type         = "EC2"
  min_size                  = var.webapp_numInstances
  max_size                  = var.webapp_numInstances
  desired_capacity          = var.webapp_numInstances
  wait_for_capacity_timeout = 0

  target_group_arns = module.alb.target_group_arns
  # target_group_arns = [aws_lb_target_group.stickyGroup.arn] not yet able to associate aws_lb_target_group into module alb
  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    }
  ]

}
