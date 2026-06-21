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

# iam policy document DATA SOURCE for ec2 s3 access
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

# iam policy RESOURCE for s3 read only access
resource "aws_iam_policy" "s3-read-only" {
  name        = "s3-read-only"
  description = "read only access to s3 buckets"

  policy = data.aws_iam_policy_document.ec2-s3-access.json
}

# iam group policy attachment
resource "aws_iam_group_policy_attachment" "devs-group-s3-read-only" {
  group      = aws_iam_group.devs-group.name
  policy_arn = aws_iam_policy.s3-read-only.arn
}