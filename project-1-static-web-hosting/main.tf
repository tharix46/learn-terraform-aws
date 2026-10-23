# general purpose account regional namespace s3 bucket
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "static-web" {

  bucket = replace("${local.name_prefix}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an", "_", "-")

  # enable the account regional namespace feature
  bucket_namespace = "account-regional"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}"
  }
}

# enable bucket versioning
resource "aws_s3_bucket_versioning" "static-web" {
  bucket = aws_s3_bucket.static-web.id

  versioning_configuration {
    status = "Enabled"
}
}

# block public access
resource "aws_s3_bucket_public_access_block" "static-web" {
  bucket = aws_s3_bucket.static-web.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# cloudfront origin access control
resource "aws_cloudfront_origin_access_control" "static-web" {
  name                              = "static-web-origin-access-control"
  description                       = "CloudFront origin access control for S3 bucket ${aws_s3_bucket.static-web.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
