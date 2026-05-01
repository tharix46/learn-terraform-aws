# DEPENDS_ON 

`depends_on` is used to handle explicit dependencies. 

It tells Terraform the exact order in which to create or destroy resources when it cannot figure it out automatically.

---

### Implicit vs. Explicit Dependencies

- **Implicit (Automatic):** If Resource B uses an attribute from Resource A, Terraform knows it must create Resource A first.

- **Explicit (Manual):** Sometimes, Resource B needs Resource A to exist, but they don't share any data in the code. This is where you use `depends_on`.

---

### The Problem

Imagine you are creating an IAM Role and an S3 Bucket that uses that role. 

If your **code doesn't directly link them**, Terraform might try to create both at the same time. 

If the S3 bucket creation starts before the IAM role is fully active, the deployment will fail.

---

### The Solution

Add `depends_on` inside the resource block that must wait.

```hcl
# Resource 1: The "Requirement"
resource "aws_iam_role" "example" {
  name = "s3-admin-role"
  assume_role_policy = "..." 
}

# Resource 2: The "Dependent"
resource "aws_s3_bucket" "example" {
  bucket = "my-secure-bucket"

  depends_on = [
    aws_iam_role.example
  ]
}
```

---

