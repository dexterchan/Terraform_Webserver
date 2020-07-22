

resource "aws_launch_configuration" "as_conf" {
  image_id        = var.webapp_ami
  instance_type   = var.instance_type
  security_groups = var.vpc_sg_ids
  name_prefix     = "ECS-${var.ecs_cluster_name}"

  iam_instance_profile = var.aws_iam_instance_profile

  key_name = var.key_name

  associate_public_ip_address = var.associate_public_ip_address
  user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
  
}
