variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "Dev"
}

variable "Project" {
  description = "project name"
  type        = string
  default     = "Terraform-Demo"
}

variable "instance_count" {
  description = "number of ec2 instances to create"
  type        = number
  default     = 1
}