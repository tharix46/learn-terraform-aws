provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.Project
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}