variable "webapp_ami" {
  description = "webapp ami"
}

variable "vpc_sg_ids" {
  description = "security group id"
}

variable "iamrole" {
  description = "iam role to run the service"
}

variable "vpc_id" {
  description = "vpc_id"
}

variable "subnets_vpc_endpoint" {
  description = "subnet of vpc endpoint"
}

variable "vpc_sg_private_ids" {
  description = "security group of vpc endpoint"
}
