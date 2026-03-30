output "bucket_name" {
  description = "name of the S3 bucket"
  value       = aws_s3_bucket.demo-s3-bucket.bucket
}

output "bucket_details" {
  description = "bucket details"
  value = {
    name = aws_s3_bucket.demo-s3-bucket.bucket
    arn  = aws_s3_bucket.demo-s3-bucket.arn
  }
}

output "environment" {
  description = "environment from input variable"
  value       = var.environment
}