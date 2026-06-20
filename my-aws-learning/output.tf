output "iam_user_info" {
  description = "details of the iam user"
  value = {
    name = aws_iam_user.cli-user.name
    arn  = aws_iam_user.cli-user.arn
    unique_id = aws_iam_user.cli-user.unique_id
    
  }
}

output "iam_group_info" {
  description = "details of the iam group"
  value = {
    name = aws_iam_group.cli-group.name
    arn  = aws_iam_group.cli-group.arn
    unique_id = aws_iam_group.cli-group.unique_id
  }
}


