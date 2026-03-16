terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35"
    }
  }

  backend "s3" {
    # s3 bucket name for state storage
    bucket = "tf-state-test-bucket-982739"
    # state file path within the bucket
    key    = "dev/terraform.tfstate"
    # s3 bucket region
    region = "us-east-1"
    # encrypt state file
    encrypt = true
    # enable s3 native state locking
    use_lockfile = true
  }

  required_version = "~> 1.14.0"
}

# configure the aws provider
provider "aws" {
  region = "us-east-1"
}

# create s3 bucket
resource "aws_s3_bucket" "demo-s3-bucket" {
  bucket = "tf-test-bucket-982739"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}