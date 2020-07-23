variable "webapp_ami" {
  description = "webapp ami"
}

variable "instance_type"{
  description = "instance type"
  default = "t2.micro"
}

variable "vpc_sg_ids" {
  description = "security group id"
}

variable "aws_iam_instance_profile" {
  description = "iam role to run instance service"
  type = string
}

variable "vpc_id" {
  description = "vpc_id"
}

variable "key_name" {
  description = "key name"
}

variable "ecs_cluster_name"{
  description = "ecs cluster name"
}

variable "associate_public_ip_address"{
  description = "associate public ip address"
}