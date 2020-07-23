locals {
  name        = "terraform-ecs"
  environment = "dev"

  # This is the convention we use to know what belongs to each other
  ec2_resources_name = "${local.name}-${local.environment}"
}
/*
module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  name   = local.name
  tags = {
    Environment = local.environment
    Name        = local.name
  }
}

module "ec2-profile" {
  source = "terraform-aws-modules/ecs/aws//modules/ecs-instance-profile"
  name   = local.name
}


#----- ECS  Services--------

module "hello-world" {
  source     = "./modules/service-hello-world"
  cluster_id = module.ecs.this_ecs_cluster_id
}


#----- ECS  Resources--------

#For now we only use the AWS ECS optimized ami <https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html>
data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}


module "this" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = local.ec2_resources_name

  # Launch configuration
  lc_name = local.ec2_resources_name

  image_id             = data.aws_ami.amazon_linux_ecs.id
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.bastion_ssh.id]
  iam_instance_profile = module.ec2-profile.this_iam_instance_profile_id
  user_data            = data.template_file.user_data.rendered

  # Auto scaling group
  asg_name                  = local.ec2_resources_name
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = local.environment
      propagate_at_launch = true
    },
    {
      key                 = "Cluster"
      value               = local.name
      propagate_at_launch = true
    },
  ]
}


data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash
# ECS config
{
  echo "ECS_CLUSTER=${local.name}"
} >> /etc/ecs/ecs.config
start ecs
echo "Done"
EOF


}
*/


module "ecs-public-cluster"{
  source  = "./modules/ecs-cluster-ec2-public"  
  ecs_cluster_name = local.ec2_resources_name
  
  launch_config_security_group = [
    aws_security_group.web-app.id,
    aws_security_group.bastion_ssh.id
  ]
  vpc_id = module.vpc.vpc_id

  key_name = aws_key_pair.deployer.key_name

  asg_subnets = module.vpc.public_subnets
  alb_subnets = module.vpc.public_subnets

  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  ALB_security_group = [
    aws_security_group.web-dmz.id
  ]

  ssl_certificate_arn = var.ssl_certificate_arn
}