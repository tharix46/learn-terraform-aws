# The Trust Policy Document 
# a data block reads or generates information, but it does not create real infrastructure on AWS by itself
data "aws_iam_policy_document" "ec2_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Resource 1: IAM Role
# This uses the trust policy created above, using a reference to the data block
resource "aws_iam_role" "app_role" {
  name               = "app-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy.json
}


# Resource 2: Attach S3 read only access policy to the role (no attribute is referenced by EC2 below)
resource "aws_iam_role_policy_attachment" "s3_read_only_access" {
  role       = aws_iam_role.app_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Resource 3: Instance Profile
# This attaches the role to an instance profile which is then attached to the EC2 instance
resource "aws_iam_instance_profile" "app_profile" {
  name = "app-profile" 
  role = aws_iam_role.app_role.name
}

# Resource 4: EC2 instance that depends on the policy being attached
resource "aws_instance" "app_server" {
  ami                  = "ami-0a2b6680ef4ed0596"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.app_profile.name

  # Terraform knows about the instance_profile above (implicit dependency),
  # but it does NOT know the S3 policy must be attached first.
  # We make that dependency explicit here.
  depends_on = [
    aws_iam_role_policy_attachment.s3_read_only_access
  ]
}