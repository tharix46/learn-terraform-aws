# Providers

### What are Providers?

Bridge between Terraform and the APIs of cloud providers, SaaS providers, and other services. In simple, Providers are plugins.
They enable Terraform to manage resources on these platforms by translating Terraform configurations into API calls.

For AWS, we use the **hashicorp/aws provider**.

---

### Terraform Version vs Provider Version

Terraform and Providers have independent versioning and release cycles.

- **Terraform Version**: The version of the Terraform CLI tool itself.
- **Provider Version**: The version of a specific provider plugin (e.g., AWS, Azure, GCP) that Terraform uses to interact with a particular service.

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
      version = "~> 6.32.1"
    }
  }
  required_version = "~> 1.14.0"
}
```

- **required_providers** is for the provider version.
- **required_version** is for the terraform version.

---

### What Terraform Actually Does When You Mention Versions

- When you run `terraform init`, Terraform downloads the provider plugin that matches the version constraint you specified.
- Terraform stores the downloaded provider plugin under `.terraform/providers/`.
- If your installed Terraform doesn’t match required_version → error
- If existing provider version doesn’t match → Terraform fetches the correct one from registry

> Terraform locks these versions in `.terraform.lock.hcl`.

---

### Terraform Providers Lock

Running `terraform init` will automatically generate or update `.terraform.lock.hcl`.

But when you want to update or generate lock files for multiple platforms, you can use the `terraform providers lock` command.

**Example:**

You use mac, but your GitHub Actions runner uses linux.
Each platform has different provider binaries → different checksums.

```bash
# creates correct lock entries for your CI/CD pipeline
# This adds linux_amd64 checksums to the existing .terraform.lock.hcl file without removing your Mac checksums.
terraform providers lock --platform=linux_amd64
```

---

### Global Plugin Cache

This is **NOT ENABLED BY DEFAULT**. 

When enabled, Terraform downloads provider plugins to a shared directory under your home folder (`~/.terraform.d/plugin-cache`) instead of inside each project's `.terraform/` folder. 

This means multiple projects can reuse the same cached provider binary rather than each project downloading its own copy — saving bandwidth and disk space.

```bash
mkdir -p ~/.terraform.d/plugin-cache
touch ~/.terraformrc

echo 'plugin_cache_dir = "/home/yourusername/.terraform.d/plugin-cache"' >> ~/.terraformrc
```
---

