provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.testPubKey
}

/*
resource "aws_instance" "bastion" {
  key_name      = aws_key_pair.deployer.key_name
  ami           = var.bastionhost_ami
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.bastion_ssh.id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "bastion"
  }
}*/

