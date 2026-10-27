variable "primary_region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "aws region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}

variable "primary_vpc_cidr_block" {
  description = "CIDR block for primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_vpc_cidr_block" {
  description = "CIDR block for secondary VPC"
  type        = string
  default     = "10.1.0.0/16"
}