locals {
  formatted_project_name = lower(replace(var.project, " ", "-"))
  name_prefix            = "${local.formatted_project_name}_${var.environment}"
}