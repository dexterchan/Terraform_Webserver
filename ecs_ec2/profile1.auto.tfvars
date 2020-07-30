region="us-west-2"
key_name="aws_humble_pig2"
testPubKey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjVLK0R0ckYd4RI8WtXRYGa+uJou8ef3brDpH2Por/FNU5/2mFe0Ow3cTBec98UgOzdrKQTkyk16zAFYLIRf0MfPOHAm+9Wl5sYFaueTGdv86nHKFFijXG0fxcsESFeoZiFdwpUcqh+lsHkdBtZaEkBBiC/DhAKastd4nn3GtAuRLs9bmZ773MZbq6uioeZyJY8X5lPBrjn23hYIPZ4+n0oJvlsyTxhz06fwBB0bWYzHObkgAPra6mSDjmHkTwrebGWkK06qVPAkBiCH6m4IWHIKSD6bb8tEzYy1ruUJPCCinYwkxkIoEIKN2fdkELf9tslea+lJqAx65ojxAk4Dds/00CKywKM1i/6+MY/aidBn3tPVx9S4reUxoyw1vNYgcOYMsqsnfyK4wPNOX9lQe3yPvmroveyv7JXZwnDkhw4NSujxE5faBNJ2ezvQhOVLl4nS11lXrFKt3p815tubhoWxD21XPiGppKywy8mEt76Yop16i8NBDyj6eDhYR01bE= dexter"

#VPC configuration
vpc_name="uswest2simplewebvpc"
vpc_azs=["us-west-2a", "us-west-2b", "us-west-2c"]
vpc_cidr="192.168.0.0/16"
vpc_public_subnets=["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
vpc_private_subnets_3=["192.168.101.0/24", "192.168.102.0/24","192.168.103.0/24",
                    "192.168.104.0/24", "192.168.105.0/24","192.168.106.0/24",
                    "192.168.107.0/24", "192.168.108.0/24","192.168.109.0/24"
                    ]
vpc_private_subnets=["192.168.101.0/24", "192.168.102.0/24","192.168.103.0/24"
                    ]
vpc_enable_nat_gateway=false
vpc_tags={
    Terraform   = "true"
    Environment = "dev"
  }

#VM configuration
bastionhost_ami="ami-063fb6d7db5d4692d"
ec2_ami="ami-01b08717623259f3a"
ec2_numInstances = 1
ASG_role_arn="arn:aws:iam::192592784707:role/docker-logs"
webapp_IAM_ROLE="docker-logs"

# Load balancer configuration
ssl_certificate_arn="arn:aws:acm:us-west-2:192592784707:certificate/ac9455d3-6b02-4455-8bcd-d41566b4972a"

# task docker image
#task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:latest"
task_docker_image="192592784707.dkr.ecr.us-west-2.amazonaws.com/marketservice:v0.py"