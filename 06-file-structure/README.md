# File Structure

### Terraform File Loading

- Terraform loads all .tf files in the current directory
- File names don't affect functionality, only organization
- All .tf files are merged into a single configuration block before processing

---

### Recommended File Structure (Instead of Everything in main.tf)

```text
project-root/
├── terraform.tf         # Terraform block
├── provider.tf          # Provider configurations
├── variables.tf         # Input variable definitions
├── locals.tf            # Local variable definitions
├── main.tf              # Main resource definitions
├── vpc.tf               # VPC-related resources
├── security.tf          # Security groups, NACLs
├── compute.tf           # EC2, Auto Scaling, etc.
├── storage.tf           # S3, EBS, EFS resources
├── database.tf          # RDS, DynamoDB resources
├── outputs.tf           # Output definitions
├── terraform.tfvars     # Variable values
├── dev.backend.hcl      # Environment-specific backend configuration
└── README.md            # Documentation
```

---

### File Organization Principles

- **Separation of Concerns**: Group related resources together
- **Logical Grouping**: Organize by service or function
- **Consistent Naming**: Use clear, descriptive file names
- **Modular Approach**: Keep files focused on specific areas
- **Documentation**: Include README and comments

---

### Common File Organization Mistakes

- **Everything in main.tf** - Makes code hard to navigate
- **Inconsistent naming** - Confuses team members
- **Mixed concerns** - Resources that don't belong together
- **No documentation** - Difficult for others to understand
- **Overly complex structure** - Simple is often better

---