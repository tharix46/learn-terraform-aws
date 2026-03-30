# Terraform Variables

### Why Variables?

Hardcoding values (like an AWS Region, Instance ID, etc.) directly into your .tf files makes your code rigid, non-reusable, and dangerous.

---

### Types of Variables

Mainly there are 3 types of variables in terraform:

1. Input Variables
2. Output Variables
3. Local Variables

---

### 1. Input Variables (variables.tf)

Values you provide to Terraform - like function parameters.
They allow you to customize your Terraform configuration without hardcoding values.

You define **variables** in a **variables.tf** file. This tells Terraform to expect an input, what type it is, and provides an optional default.

```hcl
# define in variables.tf
# default values are optional

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"   
}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "tf-demo-bucket-982739"   
}

# reference with 'var.' prefix in main.tf

resource "aws_s3_bucket" "demo-s3-bucket" {
  bucket = var.bucket_name    # using input variable

  tags = {
    Environment = var.environment   # using input variable
  }
}
```

---

### How to Pass Values to Input Variables

1. Command line arguments (`-var` and `-var-file`)
```bash
# using -var
tf plan -var="environment=staging" -var="bucket_name=tf-demo-bucket"

# using -var-file
tf plan -var-file="terraform.tfvars"
```

2. Variable files (`.tfvars`)
```hcl
# in terraform.tfvars
environment = "staging"
bucket_name = "terraform-demo-bucket"
```

3. Environment variables (`TF_VAR_` prefix)
```bash
export TF_VAR_environment="staging"
export TF_VAR_bucket_name="tf-demo-bucket"

terraform plan
```

4. Default values (in `variables.tf`)

---

