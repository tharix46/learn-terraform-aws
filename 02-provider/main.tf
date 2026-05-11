# basic provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44"
    }
  }
  required_version = "~> 1.15.0"
}

provider "aws" {
  # Configuration options
  # provider uses ~/.aws/credentials for credentials
  # picking another profile instead of default profile can be done using profile option
  # profile = "my-profile"
}