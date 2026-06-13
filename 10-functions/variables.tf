variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment tier must be exactly 'dev', 'staging', or 'prod'."
  }
}

variable "project" {
  description = "project name"
  type        = string
  default     = "tf-meta-args-demo"
}

variable "ec2_instance_types" {
  description = "the ec2 instance types based on environment"
  type        = map(string)
  default = {
    dev     = "t3.micro"
    staging = "t3.micro"
    prod    = "t3.large"
  }

  validation {
    condition     = alltrue([for type in values(var.ec2_instance_types) : can(regex("^t3\\.", type))])
    error_message = "All EC2 instance types must be in the t3 family (e.g. t3.micro, t3.small)."
  }
}

variable "ec2_instance_count" {
  description = "number of ec2 instances to create"
  type        = number
  default     = 1
}

variable "ec2_root_block_device_size" {
  description = "root block device storage size for ec2 instance in GB"
  type        = number
  default     = 8
}

variable "ec2_root_block_device_volume_type" {
  description = "root block device volume type for ec2 instance"
  type        = string
  default     = "gp3"
}

variable "ec2_monitoring" {
  description = "enable detailed monitoring for ec2 instances"
  type        = bool
  default     = false
}

variable "ec2_associate_public_ip" {
  description = "associate public ip to ec2 instance"
  type        = bool
  default     = true
}

variable "ec2_user_data_script_path" {
  description = "path to userdata script relative to the module root"
  type        = string
  default     = "userdata.sh"

  validation {
    condition     = fileexists("${path.module}/${var.ec2_user_data_script_path}")
    error_message = "Userdata script not found."
  }
}

variable "sg_allowed_ingress_ports" {
  description = "map of service name to port number"
  type        = map(number)
  default = {
    ssh  = 22
    http = 80
  }
}
