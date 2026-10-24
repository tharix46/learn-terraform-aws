locals {
  project_name = "p1-static-web-hosting"
  name_prefix  = "${local.project_name}_${var.environment}"
  s3_origin_id = "static_web_origin"
}