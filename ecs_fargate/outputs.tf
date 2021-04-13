output "lb_dns1" {
  description = "DNS Name of ALB 1"
  value       = module.ecs-private-cluster-1.lb_dns
}
output "lb_dns2" {
  description = "DNS Name of ALB 2"
  value       = module.ecs-private-cluster-2.lb_dns
}
