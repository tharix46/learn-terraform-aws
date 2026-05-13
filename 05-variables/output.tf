# output a resource attribute (bucket name)
output "bucket_name" {
  description = "name of the S3 bucket"
  value       = aws_s3_bucket.demo-s3-bucket.bucket
}

# output multiple values
output "bucket_details" {
  description = "bucket details"
  value = {
    id  = aws_s3_bucket.demo-s3-bucket.id
    arn = aws_s3_bucket.demo-s3-bucket.arn
  }
}

# output an input variable (to confirm what was used)
output "environment" {
  description = "environment from input variable"
  value       = var.environment
}