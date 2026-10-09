# DEPENDS_ON

`depends_on` is used to handle explicit dependencies.

It tells Terraform the exact order to create or destroy resources when it cannot figure it out automatically.

---

### Implicit vs. Explicit Dependencies

- **Implicit (Automatic):** If Resource B uses an attribute from Resource A, Terraform knows it must create Resource A first.

- **Explicit (Manual):** Sometimes, Resource B needs Resource A to exist, but they don't share any data in the code. This is where you use `depends_on`.

---

### The Problem

Imagine you launch an EC2 instance that needs to call S3 APIs on startup (e.g., download a config file from S3).

You have:

1. An **IAM Role** attached to the EC2 instance via an Instance Profile.
2. An **IAM Policy Attachment** that grants the role S3 access.

Terraform sees that the EC2 instance references the `aws_iam_instance_profile`, so it creates an implicit dependency on the profile — **but it does NOT know** that the S3 policy must also be attached before the instance boots.

This is an invisible **side-effect dependency**. If the instance starts before the policy is attached, the startup script will fail with an access denied error.

---

### The Solution

Use `depends_on` to tell Terraform to wait for the policy attachment before launching the EC2 instance.

```hcl
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
```

---
