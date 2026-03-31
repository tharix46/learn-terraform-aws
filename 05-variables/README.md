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
tf plan -var-file="dev.tfvars"
tf plan -var-file="prod.tfvars"
```

2. Variable files (`.tfvars`)
```hcl
# in terraform.tfvars
environment = "staging"
bucket_name = "tf-demo-bucket"
```

3. Environment variables (`TF_VAR_` prefix)
```bash
export TF_VAR_environment="staging"
export TF_VAR_bucket_name="tf-demo-bucket"

terraform plan
```

4. Default values (in `variables.tf`)

---

### 2. Output Variables (outputs.tf)

Values you want to output from Terraform - like function return values. 

They **display** important information **after Terraform creates your infrastructure**.

```hcl
# define in outputs.tf

# output a resource attribute (bucket name)
output "bucket_name" {
  description = "name of the S3 bucket"
  value       = aws_s3_bucket.demo-s3-bucket.bucket
}

# output multiple values
output "bucket_details" {
  description = "bucket details"
  value = {
    name = aws_s3_bucket.demo-s3-bucket.bucket
    arn  = aws_s3_bucket.demo-s3-bucket.arn
  }
}

# output an input variable (to confirm what was used)
output "environment" {
  description = "environment from input variable"
  value       = var.environment
}
```

```bash
# after running terraform apply, you can view outputs

# show all outputs
tf output                    

# show specific output
tf output bucket_name        

# show all outputs in JSON format
tf output -json              
```

---

### 3. Local Variables (locals.tf)

Internal computed values - like local variables in programming

```hcl
locals {
  # common tags applied to all resources
  common_tags = {
    Environment = var.environment
    Project     = "tf-demo"
    Owner       = "devops-team"
  }

  # full bucket name with environment prefix
  full_bucket_name = "${var.environment}-${var.bucket_name}-${random_string.suffix.result}"
}
```

---

### What This Project (05-variables) Does?

This project creates a simple S3 bucket that demonstrates all three variable types:

- Uses input variables for environment and bucket name
- Uses local variables for computed bucket name and tags
- Uses output variables to show the created bucket details

---

### Terraform Commands I Used

```bash
tf init 
tf validate
tf fmt
tf plan

tf apply --auto-approve

tf output

tf destroy --auto-approve
```

---