# string type
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
  default     = "tf-type-constraints-demo"
}

variable "instance_type" {
  description = "the ec2 instance type"
  type        = string
  default     = "t3.micro"
}

# number type
variable "instance_count" {
  description = "number of ec2 instances to create"
  type        = number
  default     = 1
}

variable "root_block_device_size" {
  description = "root block device storage size for ec2 instance in GB"
  type        = number
  default     = 8
}

variable "root_block_device_volume_type" {
  description = "root block device volume type for ec2 instance"
  type        = string
  default     = "gp3"
}

# bool type
variable "monitoring" {
  description = "enable detailed monitoring for ec2 instances"
  type        = bool
  default     = false
}

variable "associate_public_ip" {
  description = "associate public ip to ec2 instance"
  type        = bool
  default     = true
}

# map type
variable "allowed_ingress_ports" {
  description = "map of service name to port number"
  type        = map(number)
  default = {
    ssh  = 22
    http = 80
  }
}
