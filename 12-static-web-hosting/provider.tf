provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "p1-static-web-hosting"
      CreatedBy   = "Tharindu Lakshan"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}