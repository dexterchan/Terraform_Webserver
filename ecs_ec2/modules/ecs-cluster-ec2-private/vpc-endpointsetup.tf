
resource "aws_vpc_endpoint" "cloudwatch_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.launch_config_security_group
  subnet_ids          = var.asg_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-agent_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs-agent"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.launch_config_security_group
  subnet_ids          = var.asg_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-telemetry_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs-telemetry"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.launch_config_security_group
  subnet_ids          = var.asg_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecs"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.launch_config_security_group
  subnet_ids          = var.asg_subnets
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_vpc_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.launch_config_security_group
  subnet_ids          = var.asg_subnets
  private_dns_enabled = true
}