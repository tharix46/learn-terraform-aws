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

