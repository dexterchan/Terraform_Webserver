
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
}
