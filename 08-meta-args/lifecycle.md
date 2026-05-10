# LIFECYCLE

A special configuration block that changes how Terraform handles a resource's creation, modification, and destruction. 

Normally, Terraform follows a strict "delete then create" flow; lifecycle allows you to override this rule for safety or efficiency.

---

### 1. create_before_destroy 

By default, if a change requires a resource to be replaced, Terraform deletes the old one first and then creates the new one. This causes **"downtime."**

Setting `create_before_destroy = true` makes Terraform **create the new resource first, verify it’s working, and only then delete the old one.**

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}
```

---

### 2. prevent_destroy 

If anyone accidentally runs `terraform destroy` or makes a change that forces a replacement, Terraform will error out and **refuse to delete the resource**.

> This is the ultimate “emergency brake” for critical infrastructure.

```hcl
resource "aws_rds_instance" "production_db" {
  engine         = "postgres"
  instance_class = "db.r5.large"
  db_name        = "prod_db"

  lifecycle {
    prevent_destroy = true
  }
}
```

> To actually delete the resource later, you must manually set this to `false` in the code first.
> This prevents accidental deletion of your most important assets.

---

### 3. ignore_changes 

Sometimes, things **outside of Terraform** change your resource. 
e.g., an auto-scaling group changing the capacity, or a human adding a tag in the AWS Console. 

Normally, Terraform would try to "fix" it by reverting those changes.

Use `ignore_changes` to tell Terraform: "I know these specific attributes might change; leave them alone."

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  lifecycle {
    ignore_changes = [
      tags,           # ignores all tag changes
      instance_type,  # ignores if someone manually resizes the VM
    ]
  }
}
```

---

### 4. replace_triggered_by

Normally, Terraform only replaces a resource if its own configuration changes.

`replace_triggered_by` tells Terraform: "If Resource A changes, you must destroy and recreate Resource B immediately."

```hcl
resource "aws_instance" "app_server" {
  ami = "ami-12345678"

  lifecycle {
    # if the user-data script changes, recreate the whole server
    replace_triggered_by = [
      aws_s3_object.bootstrap_script
    ]
  }
}
```

---

### 5. Precondition

Checks a condition before Terraform starts creating or updating the resource. If the condition is false, Terraform stops and throws an error.

---

### 6. Postcondition

Checks a condition after the resource is created or updated. If the cloud provider (AWS) created something that doesn't meet your rules, Terraform fails the apply and tells you why.

---

### Summary 

| Feature | Action | Use Case |
| :--- | :--- | :--- |
| `create_before_destroy` | New resource appears before old one dies. | Zero-downtime deployments. |
| `prevent_destroy` | Terraform blocks the destroy command. | Protecting Databases/Production data. |
| `ignore_changes` | Stops Terraform from "fixing" specific fields. | Avoiding conflicts with Auto-scaling or manual edits. |
| `replace_triggered_by` | Recreates a resource when another resource changes. | Triggering updates based on external changes. |
| `precondition` | Checks a condition before creation/update. | Enforcing rules before deployment. |
| `postcondition` | Checks a condition after creation/update. | Verifying successful deployment. |

---