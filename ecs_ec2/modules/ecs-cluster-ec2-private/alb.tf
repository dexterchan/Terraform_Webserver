module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.alb_subnets
  security_groups = var.ALB_security_group

  create_lb = true
  
  enable_http2 = true

  target_groups = [
    {
      name_prefix      = "webapp"
      backend_protocol = "HTTP"
      target_type      = "instance"
      backend_port = 80
      health_check = {
        enabled  = true
        interval = 5
        path     = "/mgt/health"
        port     = "traffic-port"
        timeout  = 4
        protocol = "HTTP"
        matcher  = "200-299"
      }
      stickiness = {
        type            = "lb_cookie"
        cookie_duration = 120
        enabled         = true
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.ssl_certificate_arn
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

