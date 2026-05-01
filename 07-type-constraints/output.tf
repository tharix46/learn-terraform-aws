output "environment" {
  description = "environment from input variable"
  value       = var.environment
}

output "instance_count" {
  description = "number of ec2 instances to create"
  value       = var.instance_count
}

output "instance_id" {
  description = "id of the ec2 instance"
  value       = aws_instance.demo[*].id
}
