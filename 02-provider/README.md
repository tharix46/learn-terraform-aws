# Providers

### What are Providers?

Bridge between Terraform and the APIs of cloud providers, SaaS providers, and other services. In simple, Providers are plugins.
They enable Terraform to manage resources on these platforms by translating Terraform configurations into API calls.

For AWS, we use the **hashicorp/aws provider**.

---

### Terraform Version vs Provider Version

Terraform and Providers have independent versioning and release cycles.

- Terraform Version: The version of the Terraform CLI tool itself.
- Provider Version: The version of a specific provider plugin (e.g., AWS, Azure, GCP) that Terraform uses to interact with a particular service.

---

### Why Version Matters

- **Compatibility**: Ensure provider works with your Terraform version
- **Stability**: Pin to specific versions to avoid breaking changes
- **Features**: New provider versions add support for new AWS services
- **Bug Fixes**: Updates often include important security and bug fixes
- **Reproducibility**: Same versions ensure consistent behavior across environments

---

### Version Constraints

- `= 1.2.3` - Exact version
- `!= 1.2.3` - anything except this version
- `> 1.2` - Greater than
- `< 1.2` - Less than
- `>= 1.2` - Greater than or equal to
- `<= 1.2` - Less than or equal to
- `~> 1.2` - Pessimistic constraint

---

### Best Practices

1. Always specify provider versions
2. Use pessimistic constraints for stability
3. Test provider upgrades in development first
4. Use `terraform providers lock` command for consistency

---

### Example Provider Configuration

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.25.0"
    }
  }
  required_version = "~> 1.14.0"
}
```

- **required_version** is for the terraform version.
- **required_providers** is for the provider version.

---
