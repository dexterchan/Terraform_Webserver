
module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name           = "webapp"
  instance_count = var.webapp_numInstances
  ami                    = var.webapp_ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = var.vpc_sg_ids
  subnet_id              = var.subnet_id

  tags = var.tags
  
}