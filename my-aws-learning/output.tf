# iam outputs
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

output "ec2_s3_access_policy_info" {
  description = "details of the ec2-s3-access policy"
  value = {
    arn              = aws_iam_policy.ec2-s3-access.arn
    policy_id        = aws_iam_policy.ec2-s3-access.policy_id
    attachment_count = aws_iam_policy.ec2-s3-access.attachment_count
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
    id          = aws_iam_instance_profile.ec2-s3-access.id
    arn         = aws_iam_instance_profile.ec2-s3-access.arn
    create_date = aws_iam_instance_profile.ec2-s3-access.create_date
  }
}

# vpc outputs
output "default_vpc_info" {
  description = "details of the default VPC"
  value = {
    id         = data.aws_vpc.default-vpc.id
    arn        = data.aws_vpc.default-vpc.arn
    cidr_block = data.aws_vpc.default-vpc.cidr_block
  }
}

output "dev_vpc_info" {
  description = "details of the dev-vpc"
  value = {
    id         = aws_vpc.dev-vpc.id
    arn        = aws_vpc.dev-vpc.arn
    name       = aws_vpc.dev-vpc.tags_all["Name"]
    cidr_block = aws_vpc.dev-vpc.cidr_block
    region     = aws_vpc.dev-vpc.region
  }
}

output "public_subnet_info" {
  description = "details of the public subnets"
  value = {
    for k, v in aws_subnet.public-subnets : k => {
      id                = v.id
      arn               = v.arn
      name              = v.tags_all["Name"]
      cidr_block        = v.cidr_block
      availability_zone = v.availability_zone
    }
  }
}
  