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

output "devs_read_only_policy_info" {
  description = "details of the devs read only policy"
  value = {
    arn              = aws_iam_policy.devs-read-only.arn
    policy_id        = aws_iam_policy.devs-read-only.policy_id
    attachment_count = aws_iam_policy.devs-read-only.attachment_count
  }
}

output "ec2_s3_access_role_info" {
  description = "details of the ec2-s3-access role"
  value = {
    id          = aws_iam_role.ec2-s3-access.id
    arn         = aws_iam_role.ec2-s3-access.arn
    create_date = aws_iam_role.ec2-s3-access.create_date
  }
}

output "ec2_s3_access_instance_profile_info" {
  description = "details of the ec2-s3-access instance profile"
  value = {
    id          = aws_iam_instance_profile.ec2-s3-instance-profile.id
    arn         = aws_iam_instance_profile.ec2-s3-instance-profile.arn
    create_date = aws_iam_instance_profile.ec2-s3-instance-profile.create_date
  }
}

output "ec2_s3_access_policy_info" {
  description = "details of the ec2-s3-access policy"
  value = {
    arn              = aws_iam_policy.ec2-s3-access.arn
    policy_id        = aws_iam_policy.ec2-s3-access.policy_id
    attachment_count = aws_iam_policy.ec2-s3-access.attachment_count
  }
}

