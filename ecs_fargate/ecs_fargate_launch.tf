locals {
  name        = "mkt-pub"
  environment = "dev"

  # This is the convention we use to know what belongs to each other
  ecs_resource_name = "${local.name}-1-${local.environment}"
}

module "ecs-private-cluster" {
  source = "./modules/ecs-cluster-fargate-private"
  region = var.region

  ecs_cluster_name = local.ecs_resource_name


  vpc_id = module.vpc.vpc_id

  key_name = aws_key_pair.deployer.key_name

  asg_subnets = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  alb_subnets = module.vpc.public_subnets


  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.numOfWebAppInstances

  ALB_security_group = [
    aws_security_group.web-dmz.id
  ]
  launch_config_security_group = [
    aws_security_group.web-app.id
  ]

  ssl_certificate_arn = var.ssl_certificate_arn

  task_docker_image = var.task_docker_image

  route53_zone_id           = var.route53_zone_id
  route53_A_record_hostname = var.route53_A_record_hostname

  ecs_task_app_execution_role-arn      = aws_iam_role.ecs_task_app_execution_role.arn
  ecs_terraform_taskexecution_role-arn = aws_iam_role.ecs_terraform_taskexecution_role.arn
  depends_on = [
    aws_vpc_endpoint.cloudwatch,
    aws_vpc_endpoint.ecs-agent,
    aws_vpc_endpoint.ecs-telemetry,
    aws_vpc_endpoint.ecs,
    aws_vpc_endpoint.ecr_dkr,
    aws_vpc_endpoint.ecr_api
  ]
}
