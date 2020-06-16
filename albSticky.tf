resource "aws_lb_target_group" "stickyGroup" {
  name     = "tf-sticky-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  stickiness {
      type = "lb_cookie"
      cookie_duration = 120
      enabled = true
  }

  health_check{
      enabled = true
      interval = 5
      path = "/"
      port = "traffic-port"
      timeout = 4
      matcher = "200-299"
  }
}