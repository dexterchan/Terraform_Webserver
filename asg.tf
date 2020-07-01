module "privatewebgrp_asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "privateweb-grp"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  create_lc = true
  lc_name   = "privateweb-lc"

  image_id      = var.webapp_ami
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web-app.id,
  aws_security_group.bastion_ssh_private.id]

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

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
