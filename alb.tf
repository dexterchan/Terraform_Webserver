module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.web-dmz.id]

  create_lb = true
  #access_logs = {
  #  bucket = "humblepig2020mar-log"
  #}

  enable_http2 = true

  target_groups = [
    {
      name_prefix      = "webapp"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled  = true
        interval = 5
        path     = "/"
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

  tags = {
    Environment = "Test"
  }
}

