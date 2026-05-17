variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "project name"
  type        = string
  default     = "terraform-demo"
}

variable "instance_count" {
  description = "number of ec2 instances to create"
  type        = number
  default     = 1
}