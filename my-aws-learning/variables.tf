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