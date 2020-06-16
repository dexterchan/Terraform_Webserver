# Output variable definitions

output "arn" {
  description = "ARN of the aws"
  value       = module.ec2_instances.arn
}