# Output variable definitions

output "asgname" {
  description = "asg name"
  value       = aws_launch_configuration.as_conf.name
}
