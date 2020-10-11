output "lb_dns" {
  description = "DNS Name of ALB"
  value       = aws_lb.fargate.dns_name
}
