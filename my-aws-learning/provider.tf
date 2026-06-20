provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = var.project
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}