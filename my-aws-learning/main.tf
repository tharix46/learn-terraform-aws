# iam user
resource "aws_iam_user" "cli-user" {
  name = "cli-user"
}

# iam group
resource "aws_iam_group" "cli-group" {
  name = "cli-group"
}

# iam user group membership
resource "aws_iam_user_group_membership" "cli-group-membership" {
  user   = aws_iam_user.cli-user.name
  groups = [aws_iam_group.cli-group.name]
}