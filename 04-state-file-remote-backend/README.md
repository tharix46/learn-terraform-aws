# State File Management - Remote Backend

How Terraform Updates Infrastructure

Desired state: the infrastructure that we want to create
Actual state: the infrastructure that we have
does with terraform.tfstate file. This file should be kept as a confidential file.

Goal: Keep actual state same as desired state
State File: Actual state resides in terraform.tfstate file
Process: Terraform compares current state with desired configuration
Updates: Only changes the resources that need modification

Terraform State File

The state file is a JSON file that contains:
Resource metadata and current configuration
Resource dependencies
Provider information
Resource attribute values

Remote Backend with S3

This is where we store the terraform.tfstate file. When we run terraform apply, terraform will check the state file in the remote backend. This bucket should be already available when we run terraform apply as this contains the state file.