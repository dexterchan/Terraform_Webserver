variable "webapp_ami" {
  description = "webapp ami"
}

variable "webapp_numInstances" {
  description = "number of webapp"
}

variable "vpc_sg_ids"{
    description = "security group id"
}

variable "subnet_id"{
    description = "subnet id"
}

variable "tags"{
  description = "tags"
  type = map(string)
}