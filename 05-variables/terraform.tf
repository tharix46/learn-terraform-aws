terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "s3" {
    # instead of adding bucket name, key, and region here, they are passed as a command line argument for 'tf init'
    # using dev.backend.hcl file: 
    # tf init -backend-config="dev.backend.hcl"
    # a good approach for environment-specific state paths.
    # bucket       = "tf-state-test-bucket-982739"
    # key          = "dev/terraform.tfstate"
    # region       = "us-east-1"

    encrypt      = true
    use_lockfile = true
  }

  required_version = "~> 1.15.0"
}