# COUNT

The `count` meta-argument is used to create **multiple instances of a resource** without duplicating code blocks.

Resources are created in parallel (unless dependencies exist).

---

### The Problem (DRY)

Hard coding the same resource multiple times is a manual repetition which leads to errors and waste of time.

```hcl
# ❌ INCORRECT (Waste of time)
resource "aws_s3_bucket" "bucket-1" {
  bucket = "my-app-data-1"
}

resource "aws_s3_bucket" "bucket-2" {
  bucket = "my-app-data-2"
}

resource "aws_s3_bucket" "bucket-3" {
  bucket = "my-app-data-3"
}
```

---

### The Solution

By adding `count` meta-argument, Terraform loops through the block and creates multiple instances of a resource.

```hcl
# ✅ CORRECT
resource "aws_s3_bucket" "multi-bucket" {
  count  = 3
  bucket = "my-app-data-${count.index}"

  tags = {
    Name = "my-app-data-${count.index}"
  }
}
```

---

### `count.index`

- `count = 3` tells Terraform to create exactly 3 instances of this resource.
- `count.index` is a built-in object available within resource blocks that use the count meta-argument.
- Represents the **index of the current resource** being created (0, 1, 2, ...).
- Useful for creating unique names, IDs, or references for each instance.

---

### `count` with Variables

Instead of hardcoding the count value, use a variable.

```hcl
variable "bucket_count" {
  type    = number
  default = 2
}

resource "aws_s3_bucket" "multi-bucket" {
  count  = var.bucket_count
  bucket = "my-app-data-${count.index}"
}
```

---

### Accessing Outputs

When you use `count`, the resource becomes a list. You cannot reference it as a single object anymore.

- To get all bucket ARNs: Use a splat operator `[*]`.
- To get one specific bucket: Use the index `[0]`.

```hcl
output "all_bucket_arns" {
  value = aws_s3_bucket.multi_bucket[*].arn
}

output "first_bucket_arn" {
  value = aws_s3_bucket.multi_bucket[0].arn
}
```

---
