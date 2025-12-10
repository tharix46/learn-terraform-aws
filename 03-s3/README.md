# Create a Simple S3 Bucket

This example demonstrates how to create a simple S3 bucket using Terraform.

The configuration includes the necessary provider setup and the resource definition for the S3 bucket.

---

### Prerequisites

- Terraform installed on your machine.
- An AWS account with appropriate permissions
- AWS CLI configured with your credentials.

---

### Commands to Run

```bash
# initialize terraform
tf init

# validate configuration
tf validate

# plan changes
tf plan

# apply changes
tf apply -auto-approve
```

```bash
# destroy resources
tf destroy -auto-approve
```
