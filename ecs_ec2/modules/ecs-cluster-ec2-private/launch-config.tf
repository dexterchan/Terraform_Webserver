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

resource "aws_launch_configuration" "as_conf" {
  image_id        = data.aws_ami.amazon_linux_ecs.id
  instance_type   = var.instance_type
  security_groups = var.launch_config_security_group
  name_prefix     = "ECS-${var.ecs_cluster_name}"

  iam_instance_profile = aws_iam_instance_profile.ecs_terraform_profile.name

  key_name = var.key_name

  associate_public_ip_address = var.associate_public_ip_address
  user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_vpc_endpoint.cloudwatch,
    aws_vpc_endpoint.ecs-agent,
    aws_vpc_endpoint.ecs-telemetry,
    aws_vpc_endpoint.ecs,
    aws_vpc_endpoint.ecr_dkr,
    aws_vpc_endpoint.ecr_api,
    aws_vpc_endpoint.s3
  ]
}
