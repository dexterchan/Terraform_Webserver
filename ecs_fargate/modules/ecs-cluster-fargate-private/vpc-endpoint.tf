//reference : https://aws.amazon.com/blogs/compute/setting-up-aws-privatelink-for-amazon-ecs-and-amazon-ecr/
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-agent" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs-agent"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-telemetry" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs-telemetry"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.asg_route_table_ids
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}
/*
resource "aws_vpc_endpoint" "sts_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.sts"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.vpc-endpoint_security_group
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = true
}*/
