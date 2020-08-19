resource "aws_lb" "fargate" {
  name               = "alb"
  subnets            = var.alb_subnets
  load_balancer_type = "application"
  security_groups    = var.ALB_security_group
  enable_http2      = true

  tags = {
    Environment = "staging"
  }
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.fargate.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fargate.arn
  }
}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = aws_lb.fargate.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn    = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fargate.arn
  }
}

resource "aws_lb_target_group" "fargate" {
  name        = "webapp-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/mgt/health"
    unhealthy_threshold = "2"
  }
  stickiness {
        type            = "lb_cookie"
        cookie_duration = 120
        enabled         = true
  }
}