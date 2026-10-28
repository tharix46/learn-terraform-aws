locals {
  project_name = "p3-iam-user-management"
  name_prefix  = "${local.project_name}_${var.environment}"

  users = csvdecode(file("users.csv"))
}