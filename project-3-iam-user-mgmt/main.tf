# get aws account ID
data "aws_caller_identity" "current" {}

# create IAM users
resource "aws_iam_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  name = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")
  path = "/users/"

  tags = {
    "DisplayName" = "${each.value.first_name} ${each.value.last_name}"
    "Department"  = each.value.department
    "JobTitle"    = each.value.job_title
  }
}

# IAM user login profile (password)
resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users

  user                    = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
    ]
  }
}

# create IAM groups
resource "aws_iam_group" "education" {
  name = "education"
  path = "/groups/"
}

resource "aws_iam_group" "managers" {
  name = "managers"
  path = "/groups/"
}

resource "aws_iam_group" "accountants" {
  name = "accountants"
  path = "/groups/"
}

# add users to the education group
resource "aws_iam_group_membership" "education_membership" {
  name  = "education-group-membership"
  group = aws_iam_group.education.name

  users = [
    for user in aws_iam_user.users : user.name if user.tags.Department == "Education"
  ]
}

# add users to the managers group
resource "aws_iam_group_membership" "managers_membership" {
  name  = "managers-group-membership"
  group = aws_iam_group.managers.name

  users = [
    for user in aws_iam_user.users : user.name if can(regex("Manager|CEO", user.tags.JobTitle))
  ]
}

# add users to the accountants group
resource "aws_iam_group_membership" "accountants_membership" {
  name  = "accountants-group-membership"
  group = aws_iam_group.accountants.name

  users = [
    for user in aws_iam_user.users : user.name if user.tags.Department == "Accounting"
  ]
}