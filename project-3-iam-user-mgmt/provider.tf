provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = local.project_name
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}