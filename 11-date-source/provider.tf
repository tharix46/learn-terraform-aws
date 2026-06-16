provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = local.formatted_project_name
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}