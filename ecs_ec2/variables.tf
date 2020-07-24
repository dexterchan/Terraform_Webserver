variable "region" {
  default = "us-west-2"
}
variable "key_name" {
  default = "aws_humble_pig"
}
variable "testPubKey" {}

variable "vpc_name" {
  description = "Name of VPC"
  default     = "example-vpc"
}
variable "vpc_azs" {
  description = "Availability zones for VPC"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
}
variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
}
variable "vpc_private_subnets_3" {
  description = "Private subnets for VPC 3 subnet per AZ"
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  default     = false
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
}

variable "bastionhost_ami" {
  description = "bastionhost ami"
}

variable "ec2_ami" {
  description = "ec2 ami"
}

variable "ec2_numInstances" {
  description = "number of webapp"
}

variable "ASG_role_arn" {
  description = "Auto Scaling Group ARN"
}

variable "webapp_IAM_ROLE" {
  description = "web app running with iam role"
}

variable "ssl_certificate_arn" {
  description = "arn of SSL certificate"
}

variable "min_size"{
  description = "min size"
  default = 1
}

variable "max_size"{
  description = "min size"
  default = 2
}


variable "task_docker_image"{
  description = "task docker image"
}