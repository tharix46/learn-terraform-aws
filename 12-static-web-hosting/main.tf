# general purpose account regional namespace s3 bucket
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "static-web" {

  bucket = "${local.name_prefix}_${data.aws_caller_identity.current.account_id}_${data.aws_region.current.region}-an"

  # enable the account regional namespace feature
  bucket_namespace = "account-regional"

  lifecycle {
    # TODO: set this to true
    prevent_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}"
  }
}

resource "aws_s3_bucket_versioning" "static-web" {
  bucket = aws_s3_bucket.static-web.id
  versioning_configuration {
    status = "Enabled"
  }
}