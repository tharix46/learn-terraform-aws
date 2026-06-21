output "iam_user_info" {
  description = "details of the iam user"
  value = {
    name      = aws_iam_user.dev-user.name
    arn       = aws_iam_user.dev-user.arn
    unique_id = aws_iam_user.dev-user.unique_id

  }
}

output "iam_group_info" {
  description = "details of the iam group"
  value = {
    name      = aws_iam_group.devs-group.name
    arn       = aws_iam_group.devs-group.arn
    unique_id = aws_iam_group.devs-group.unique_id
  }
}

output "iam_s3_read_only_policy_info" {
  description = "details of the s3-read-only policy"
  value = {
    name        = aws_iam_policy.s3-read-only.name
    arn         = aws_iam_policy.s3-read-only.arn
    description = aws_iam_policy.s3-read-only.description
  }
}

