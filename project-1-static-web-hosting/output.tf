output "s3_bucket_info" {
  description = "details of the s3 bucket"
  value = {
    name                 = aws_s3_bucket.static_web.bucket
    arn                  = aws_s3_bucket.static_web.arn
    region               = aws_s3_bucket.static_web.region
    regional_domain_name = aws_s3_bucket.static_web.bucket_regional_domain_name
  }
}

output "s3_bucket_tags" {
  description = "tags of the s3 bucket"
  value       = aws_s3_bucket.static_web.tags_all
}

output "s3_bucket_versioning_info" {
  description = "details of the s3 bucket versioning"
  value = {
    bucket            = aws_s3_bucket_versioning.static_web.bucket
    versioning_status = aws_s3_bucket_versioning.static_web.versioning_configuration[0].status
  }
}

output "bucket_policy_info" {
  description = "details of the s3 bucket policy"
  value = {
    bucket = aws_s3_bucket_policy.static_web.bucket
    policy = aws_s3_bucket_policy.static_web.policy
  }
}

output "cloudfront_distribution_info" {
  description = "details of the cloudfront distribution"
  value = {
    id                 = aws_cloudfront_distribution.static_web.id
    arn                = aws_cloudfront_distribution.static_web.arn
    domain_name        = aws_cloudfront_distribution.static_web.domain_name
    status             = aws_cloudfront_distribution.static_web.status
    last_modified_time = aws_cloudfront_distribution.static_web.last_modified_time
  }
}

output "cloudfront_distribution_tags" {
  description = "tags of the cloudfront distribution"
  value       = aws_cloudfront_distribution.static_web.tags_all
}