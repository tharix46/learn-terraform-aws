terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.42"
    }
  }
  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }

  required_version = "~> 1.14.0"
}

