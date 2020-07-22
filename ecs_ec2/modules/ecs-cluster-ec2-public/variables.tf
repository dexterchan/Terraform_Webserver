variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

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

variable "vpc_id" {
  description = "vpc_id"
}

variable "key_name" {
  description = "key name"
}

variable "associate_public_ip_address"{
  description = "associate public ip address"
  default = true
}