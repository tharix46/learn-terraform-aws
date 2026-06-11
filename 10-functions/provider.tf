provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}