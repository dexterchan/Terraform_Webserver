variable "region" {
    default = "us-west-2"
}
variable "key_name"{
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

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  default = false
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
}

variable "bastionhost_ami" {
  description = "bastionhost ami"
}

variable "webapp_ami" {
  description = "webapp ami"
}

variable "webapp_numInstances" {
  description = "number of webapp"
}
