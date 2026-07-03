variable "project" {
  description = "project name"
  type        = string
  default     = "my-aws-learning"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "region name"
  type        = string
  default     = "us-east-1"
}


variable "iam_user_name" {
  description = "iam user name"
  type        = string
  default     = "dev-user-1"
}

variable "iam_group_name" {
  description = "iam group name"
  type        = string
  default     = "devs"
}

variable "allowed_availability_zones" {
  description = "list of allowed availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_configs" {
  description = "allowed AZs and associate a number with it for public subnet cidr creation"
  type        = map(number)
  default = {
    "us-east-1a" = 1
    "us-east-1b" = 2
  }
}

variable "private_subnet_configs" {
  description = "allowed AZs and associate a number with it for private subnet cidr creation"
  type = map(object({
    az       = string
    new_bits = number
    net_num  = number
  }))
  default = {
    "app-us-east-1a" = { az = "us-east-1a", new_bits = 4, net_num = 1 }
    "app-us-east-1b" = { az = "us-east-1b", new_bits = 4, net_num = 2 }
    "db-us-east-1a"  = { az = "us-east-1a", new_bits = 4, net_num = 3 }
    "db-us-east-1b"  = { az = "us-east-1b", new_bits = 4, net_num = 4 }
  }
}