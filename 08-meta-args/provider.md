# PROVIDER

The provider meta-argument (used inside a resource) allows you to choose which specific provider configuration to use for a single resource.

---

### The Difference: Provider Block vs. Provider Meta-Argument

- **Provider Block**: This is the **global configuration** where you define the region, credentials, etc.

- **Provider Meta-Argument**: This is a line **inside a resource** that says, "Hey, don't use the default setup; use this specific one instead."

---

### Example Use Cases

- Deploying to a Different Region.
  - Example: Create a backup S3 bucket in a different region (`us-west-1`) instead of (`us-east-1`).
- Using different AWS accounts for different resources.
  - Example: Create an S3 bucket in a different AWS account (`prod-account`) instead of (`dev-account`).

- Using different providers for different resources.

---

### How to Use It

Create a second provider block with an `alias`.

```hcl
# Default provider (us-east-1)
provider "aws" {
  region = "us-east-1"
}

# Alternate provider (us-west-2) using an ALIAS
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```

Use `provider` meta-argument in resource.

```hcl
# This bucket goes to us-east-1 (Default)
resource "aws_s3_bucket" "east_bucket" {
  bucket = "my-primary-data"
}

# This bucket goes to us-west-2
resource "aws_s3_bucket" "west_bucket" {
  provider = aws.west
  bucket   = "my-backup-data"
}
```

---
