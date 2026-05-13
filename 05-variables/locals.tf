# local variables - internal variables for reusability

locals {
  # full bucket name with environment prefix
  full_bucket_name = "${var.environment}-${var.bucket_name}-${random_string.suffix.result}"
}

# random string for unique bucket naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}