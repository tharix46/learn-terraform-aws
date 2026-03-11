terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35"
    }
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