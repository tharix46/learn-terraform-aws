# iam user
resource "aws_iam_user" "dev-user" {
  name = var.iam_user_name
}

# iam group
resource "aws_iam_group" "devs-group" {
  name = var.iam_group_name
}

# iam user group membership
resource "aws_iam_user_group_membership" "devs-group-membership" {
  user   = aws_iam_user.dev-user.name
  groups = [aws_iam_group.devs-group.name]
}

# iam policy document defining ec2 & s3 read-only access
data "aws_iam_policy_document" "devs-read-only" {
  statement {
    sid       = "EC2ReadOnly"
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }

  statement {
    sid    = "S3ReadOnly"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]
    # TODO: change bucket name correctly when create bucket in s3 section
    resources = ["*"]
  }
}

# iam policy for devs group read-only access
resource "aws_iam_policy" "devs-read-only" {
  name        = "${local.name_prefix}_devs-read-only"
  description = "read-only access to ec2 and s3 for debugging"
  policy      = data.aws_iam_policy_document.devs-read-only.json
}

# attach read-only policy to the devs group
resource "aws_iam_group_policy_attachment" "devs-read-only-attach" {
  group      = aws_iam_group.devs-group.name
  policy_arn = aws_iam_policy.devs-read-only.arn
}

# iam policy document for ec2 -> s3 access
data "aws_iam_policy_document" "ec2-s3-access" {
  statement {
    sid    = "S3ReadOnly"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]

    # TODO: change bucket name correctly when create bucket in s3 section
    resources = [
      "arn:aws:s3:::*",
      "arn:aws:s3:::*/*",
    ]
  }

  statement {
    sid = "WriteToLogs"

    effect = "Allow"

    actions = ["s3:PutObject"]
    # TODO: change bucket name correctly when create bucket in s3 section. add path LOGS
    resources = ["arn:aws:s3:::*/logs/*"]
  }
}

# iam policy for ec2 -> s3 access
resource "aws_iam_policy" "ec2-s3-access" {
  name        = "${local.name_prefix}_ec2-s3-access"
  description = "read access to s3 bucket and write access to logs folder"
  policy      = data.aws_iam_policy_document.ec2-s3-access.json
}

# trust policy document for ec2-s3-access role to trust ec2
data "aws_iam_policy_document" "ec2-trust-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# iam role for ec2 -> s3 access
resource "aws_iam_role" "ec2-s3-access" {
  name_prefix        = "${local.name_prefix}_ec2-s3-access"
  assume_role_policy = data.aws_iam_policy_document.ec2-trust-policy.json

  lifecycle {
    create_before_destroy = true
  }
}

# iam role policy attachment for ec2 -> s3 access
resource "aws_iam_role_policy_attachment" "ec2-s3-access" {
  role       = aws_iam_role.ec2-s3-access.name
  policy_arn = aws_iam_policy.ec2-s3-access.arn
}

# iam instance profile for ec2 -> s3 access
resource "aws_iam_instance_profile" "ec2-s3-instance-profile" {
  name = "${local.name_prefix}_ec2-s3-instance-profile"
  role = aws_iam_role.ec2-s3-access.name

  lifecycle {
    create_before_destroy = true
  }
}