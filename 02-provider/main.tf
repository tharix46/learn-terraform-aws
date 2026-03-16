# basic provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35"
    }
  }
  required_version = "~> 1.14.0"
}

provider "aws" {
  # Configuration options
  # provider uses ~/.aws/credentials for credentials
  # pick another profile instead of default profile can be done using profile option
  # profile = "my-profile"
}