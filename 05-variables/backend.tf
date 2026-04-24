terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "s3" {
    bucket       = "tf-state-test-bucket-982739"
    # key          = "dev/terraform.tfstate"
    # instead of adding key here, it is passed as a command line argument for 'tf init': 
    # tf init -backend-config="key=dev/terraform.tfstate"
    # a good approach for environment-specific state paths.

    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_version = "~> 1.14.0"
}