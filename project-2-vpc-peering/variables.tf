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

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "primary_key_name" {
  description = "SSH key pair for Primary VPC instance (us-east-1)"
  type        = string
  default     = "p2-vpc-peering"
}

variable "secondary_key_name" {
  description = "SSH key pair for Secondary VPC instance (us-west-2)"
  type        = string
  default     = "p2-vpc-peering"
}