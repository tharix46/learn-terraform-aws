# Getting Started With Terraform

### What is IaC?

Provisioning your **infrastructure through code** instead of manual processes.

---

### Why IaC?

- **Consistency**: Identical environments across dev, staging, and production
- **Time Efficiency**: Automated provisioning saves hours of manual work
- **Cost Management**: Easy to track costs and automate cleanup
- **Scalability**: Deploy to hundreds of servers with same effort as one
- **Version Control**: Track changes in Git
- **Reduced Human Error**: Eliminate manual configuration mistakes
- **Collaboration**: Team can work together on infrastructure

---

### What is Terraform?

IaC tool that helps automate infrastructure provisioning and management across multiple cloud providers.

---

### How Terraform Works With AWS

Write Terraform files → Run Terraform commands → Call AWS APIs through Terraform Provider → AWS provisions resources

**Terraform Commands:**

1. `terraform init` - Initialize the working directory
2. `terraform validate` - Validate the configuration files
3. `terraform plan` - Create an execution plan
4. `terraform apply` - Apply the changes to reach desired state
5. `terraform destroy` - Destroy the infrastructure when needed

---

### Install & Configure Terraform (macOS)

```bash
# install terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# verify installation
terraform -version

# set alias and enable autocomplete
echo "alias tf=terraform" >> ~/.zshrc
source ~/.zshrc
tf -install-autocomplete
```

---
