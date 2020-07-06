
data "aws_iam_instance_profile" "servicerole" {
  name = var.iamrole
}

data "aws_ami" "app" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["ServerPingWebsocketPy2"]
  }
}

resource "aws_vpc_endpoint" "cloudwatch_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-west-2.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc_sg_private_ids
  subnet_ids          = var.subnets_vpc_endpoint
  private_dns_enabled = true
}

resource "aws_launch_configuration" "as_conf" {
  image_id        = var.webapp_ami
  instance_type   = "t2.micro"
  security_groups = var.vpc_sg_ids
  name_prefix     = "privateweb-asg"

  iam_instance_profile = data.aws_iam_instance_profile.servicerole.name
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_vpc_endpoint.cloudwatch_vpc_endpoint]
}
