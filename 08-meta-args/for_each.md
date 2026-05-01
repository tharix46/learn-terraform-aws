# FOR_EACH

While `count` is for creating multiple identical resources, `for_each` is for creating resources **based on a set of strings or a map**.

Resources are created in parallel (unless dependencies exist).

---

### The Problem

If you use count with a list `["bucket-a", "bucket-b", "bucket-c"]` and delete `bucket-a`, Terraform sees the list change. 

It shifts everything. `bucket-b` (index 1) becomes index 0, and `bucket-c` (index 2) becomes index 1. 

Terraform will destroy and recreate them.

---

### The Solution

`for_each` identifies resources by a unique **key** (like a name), not a number. 

If you delete one item, the others remain untouched because their "ID" hasn't changed.

---

### Example A: Using a Set (Simple List of Names)

```hcl
resource "aws_s3_bucket" "departments" {
  for_each = toset(["marketing", "sales", "operations"])

  bucket = "company-${each.key}-data" 
}
```

---

### Example B: Using a Map

```hcl
variable "env_configs" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t3.medium"
  }
}

resource "aws_instance" "app_server" {
  for_each      = var.env_configs
  instance_type = each.value
  ami           = "ami-0c55b159cbfafe1f0"

  tags = {
    Name = "Server-${each.key}"
  }
}
```

---

### Accessing Outputs

Since for_each creates a map of resources in the state file, you access them by their key, not an index number.

- Accessing one specific resource: `aws_instance.app_server["prod"].id`

- Accessing all (Splat doesn't work here): You must use a for expression.
```hcl
output "all_instance_ids" {
  value = [for instance in aws_instance.app_server : instance.id]
}
```

---

### Summary Comparison

| Feature | count | for_each |
| :--- | :--- | :--- |
| **Data Type** | Integer | Set of Strings or Map |
| **Identification** | Index (0, 1, 2...) | Unique Key ("marketing", "dev") |
| **Best Use Case** | Identical scaling (e.g., 5 web nodes) | Unique resources (e.g., 3 different buckets) |
| **Stability** | Fragile (Index shifts cause deletes) | Stable (Key-based mapping) |

---
