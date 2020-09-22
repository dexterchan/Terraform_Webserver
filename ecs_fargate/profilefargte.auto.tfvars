region="us-west-2"
key_name="aws_humble_pig2"
testPubKey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjVLK0R0ckYd4RI8WtXRYGa+uJou8ef3brDpH2Por/FNU5/2mFe0Ow3cTBec98UgOzdrKQTkyk16zAFYLIRf0MfPOHAm+9Wl5sYFaueTGdv86nHKFFijXG0fxcsESFeoZiFdwpUcqh+lsHkdBtZaEkBBiC/DhAKastd4nn3GtAuRLs9bmZ773MZbq6uioeZyJY8X5lPBrjn23hYIPZ4+n0oJvlsyTxhz06fwBB0bWYzHObkgAPra6mSDjmHkTwrebGWkK06qVPAkBiCH6m4IWHIKSD6bb8tEzYy1ruUJPCCinYwkxkIoEIKN2fdkELf9tslea+lJqAx65ojxAk4Dds/00CKywKM1i/6+MY/aidBn3tPVx9S4reUxoyw1vNYgcOYMsqsnfyK4wPNOX9lQe3yPvmroveyv7JXZwnDkhw4NSujxE5faBNJ2ezvQhOVLl4nS11lXrFKt3p815tubhoWxD21XPiGppKywy8mEt76Yop16i8NBDyj6eDhYR01bE= dexter"

#VPC configuration
vpc_name="uswest2simplewebvpc"
vpc_azs=["us-west-2a", "us-west-2b"]
vpc_cidr="192.168.0.0/16"
vpc_public_subnets=["192.168.1.0/24","192.168.2.0/24"]
vpc_private_subnets=["192.168.101.0/24", "192.168.102.0/24","192.168.103.0/24"]
#vpc_private_asg_subnets=["192.168.101.0/24", "192.168.201.0/24"]
#vpc_private_endpoint_subnets=["192.168.301.0/24"]
vpc_enable_nat_gateway=true
vpc_tags={
    Terraform   = "true"
    Environment = "dev"
  }

#VM configuration
bastionhost_ami="ami-063fb6d7db5d4692d"
ec2_ami="ami-01b08717623259f3a"

ASG_role_arn="arn:aws:iam::192592784707:role/docker-logs"


# Load balancer configuration
ssl_certificate_arn="arn:aws:acm:us-west-2:192592784707:certificate/ac9455d3-6b02-4455-8bcd-d41566b4972a"

# task docker image
task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:rc.java"
#task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:v4.java"
#task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:v2.nodejs"
#task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:v1.py"



route53_zone_id="Z0736580JIAOP64Z32I6"
route53_A_record_hostname="treequery.org"

min_size=1
max_size=10
numOfWebAppInstances = 2
