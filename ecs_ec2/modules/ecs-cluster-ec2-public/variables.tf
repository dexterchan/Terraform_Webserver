variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

variable "instance_type"{
  description = "instance type"
  default = "t2.micro"
}

variable "launch_config_security_group" {
  description = "launch config security group id list"
}

variable "ALB_security_group" {
  description = "ALB security group id list"
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

variable "alb_subnets" {
  description = "alb subnets"
}

variable "asg_subnets" {
  description = "asg subnets"
}

variable "min_size"{
  description = "min size"
}

variable "max_size"{
  description = "min size"
}

variable "desired_capacity"{
  description = "desired capacity"
}

variable "ssl_certificate_arn"{
  description = "arn of ssl certificate"
}