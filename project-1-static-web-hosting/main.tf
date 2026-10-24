# general purpose account regional namespace s3 bucket
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "static_web" {

  bucket = replace("${local.name_prefix}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an", "_", "-")

  # enable the account regional namespace feature
  bucket_namespace = "account-regional"

  lifecycle {
    # TODO: set to true after testing
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_bucket"
  }
}

# enable bucket versioning
resource "aws_s3_bucket_versioning" "static_web" {
  bucket = aws_s3_bucket.static_web.id

  versioning_configuration {
    status = "Enabled"
  }
}

# block public access
resource "aws_s3_bucket_public_access_block" "static_web" {
  bucket = aws_s3_bucket.static_web.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# bucket policy document to allow cloudfront to read objects in the bucket
data "aws_iam_policy_document" "origin_bucket_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadAccess"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.static_web.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.static_web.arn]
    }
  }
}

# bucket policy
resource "aws_s3_bucket_policy" "static_web" {
  bucket = aws_s3_bucket.static_web.bucket
  policy = data.aws_iam_policy_document.origin_bucket_policy.json
}

# cloudfront origin access control
resource "aws_cloudfront_origin_access_control" "static_web" {
  name                              = "static-web-origin-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# cloudfront distribution
resource "aws_cloudfront_distribution" "static_web" {
  origin {
    domain_name              = aws_s3_bucket.static_web.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.static_web.id

    # a unique label CloudFront uses to identify this origin
    origin_id = local.s3_origin_id
  }

  enabled             = true
  comment             = "cf distribution for ${local.name_prefix}"
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    # HTTP methods CloudFront will accept and send to the origin
    allowed_methods = ["GET", "HEAD"]

    # HTTP methods whose responses CloudFront may cache
    cached_methods = ["GET", "HEAD"]

    target_origin_id = local.s3_origin_id

    # doesn’t forward query strings or cookies to S3.
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  

  # control which CloudFront edge locations may serve your content, balancing coverage and cost
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Name = "${local.name_prefix}_distribution"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}