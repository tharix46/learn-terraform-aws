# State File Management & Remote Backend

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

Terraform uses `terraform.tfstate` file to **keep track of the actual state**. This file should be kept as a confidential file and should not commit to the version control.

**Two important concepts:**
1. **Desired state**: the infrastructure that we want to create
2. **Actual state**: the infrastructure that we have

The **Goal** is to **keep actual state same as desired state**.
To do that, Terraform compares actual state (from `terraform.tfstate` file) with desired state (from terraform files). Then only changes the resources that need modification.

---

### Remote Backend with S3

Remote backend is where we store the `terraform.tfstate` file. 

When we run `terraform apply`, terraform will check the state file in the remote backend. This bucket should be already available when we run `terraform apply` as this contains the state file.