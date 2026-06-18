# Data Sources

A Data Source allows Terraform to fetch and use information defined outside of your current code.

They are strictly for fetching data; they cannot create, update, or destroy infrastructure.

---

### What This Project (11-date-source) Does?

> The primary goal is to **demonstrate Terraform data sources in practice.**

This project provisions the following AWS resources:

- **IAM Role & Instance Profile** (uses data source for trust policy document)
- **EC2 instances** (uses data sources for `aws_ami` and `aws_key_pair`)
- **Security group**

State is stored remotely in an **S3 backend** with encryption and locking enabled (`dev.backend.hcl`).

---

### Terraform Commands Used in This Project

```bash
tf init -backend-config="dev.backend.hcl"
tf validate
tf fmt
tf plan -var-file="dev.tfvars"

tf apply -auto-approve -var-file="dev.tfvars"

tf providers lock --platform=linux_amd64

tf destroy -auto-approve -var-file="dev.tfvars"

```

---
