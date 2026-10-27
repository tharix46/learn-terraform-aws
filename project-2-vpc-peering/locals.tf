locals {
  project_name = "p2-vpc-peering"
  name_prefix  = "${local.project_name}_${var.environment}"
}