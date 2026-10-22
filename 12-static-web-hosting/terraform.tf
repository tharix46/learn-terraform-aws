terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.70"
    }
  }

  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }

  required_version = "~> 1.17.0"
}
