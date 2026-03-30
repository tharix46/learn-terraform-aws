# input variables - values provided to Terraform configuration

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"   
}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "tf-demo-bucket-982739"   
}