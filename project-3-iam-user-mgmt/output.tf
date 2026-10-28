output "account_info" {
  description = "details of the AWS Account"
  value       = data.aws_caller_identity.current
}

output "user_names" {
  description = "list of all user names created in this project"
  value       = [for user in local.users : "${user.first_name} ${user.last_name}"]
}
