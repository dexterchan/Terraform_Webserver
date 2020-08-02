
resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  name    = var.route53_A_record_hostname
  type    = "A"
  
  alias {
    name                   = aws_lb.fargate.dns_name
    zone_id                = aws_lb.fargate.zone_id
    evaluate_target_health = true
  }
}

