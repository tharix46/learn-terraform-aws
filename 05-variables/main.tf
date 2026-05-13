# simple s3 bucket using all three types of variables
# full_bucket_name = environment + bucket_name + random_string
# full_bucket_name -> local variable (computed)
# environment -> input variable (user defined)
# bucket_name -> input variable (user defined)
# output.tf -> output variables

resource "aws_s3_bucket" "demo-s3-bucket" {
  bucket = local.full_bucket_name
}