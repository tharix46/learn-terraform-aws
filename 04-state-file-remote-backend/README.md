# State File & Remote Backend

### Terraform State File

The state file is a **JSON file** that contains:
- **Current configuration** and resource metadata
- Resource dependencies
- Provider information
- Resource attribute values

---

### State File Best Practices

- Never edit state file manually
- Store state file remotely (not in local file system)
- Enable state locking to prevent concurrent modifications
- Backup state files regularly
- Use separate state files for different environments
- Restrict access to state files (contains sensitive data)
- Encrypt state files at rest and in transit

---

### How Terraform Updates Infrastructure

Terraform uses `terraform.tfstate` (_state file_) to **keep track of the actual state**. This file should be kept as a confidential file and should not commit to the version control.

**Two important concepts:**
1. **Desired state**: the infrastructure that we want to create
2. **Actual state**: the infrastructure that we have

The **Goal** is to **keep actual state same as desired state**.
To do that, Terraform compares actual state (from `terraform.tfstate` file) with desired state (from terraform files). Then only changes the resources that need modification.

---

### Remote Backend with S3

Remote backend is where we store the `terraform.tfstate` file. 

We can use **S3** as a remote backend and it has **S3 native state locking** using S3's **Conditional Writes** feature (_useful when multiple team members are working on the same infrastructure_).

When we run `terraform apply`, terraform will check the state file in the remote backend **S3 bucket** (_This bucket should be already available when we run `terraform apply` as this contains the state file._).

> **Important**: S3 versioning MUST be enabled for S3 native state locking to work properly.

---

### Why Use Remote Backend

- **Collaboration**: Team members can share state
- **Locking**: Prevents concurrent state modifications
- **Security**: Encrypted storage and access control
- **Backup**: Automatic versioning and backup
- **Durability**: Highly available storage

---

### Commands to Run

```bash
# initialize with new backend configuration
tf init 

tf validate
tf fmt
tf plan
tf apply --auto-approve

# list resources in state
tf state list

# pull current state and display
tf state pull

tf destroy --auto-approve
```

---