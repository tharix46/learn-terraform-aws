# Terraform Functions

In Terraform, Functions are built-in tools used to **transform data, manipulate strings, manage collections, and validate inputs dynamically during execution.**
Unlike general programming languages (Python/Go), you cannot create your own custom functions in Terraform.
You can only use the ones provided by Terraform.

---

### Different Types of Functions

- String functions:
  `lower(), upper(), replace(), substr(), trim(), split(), join(), chomp()`

- Numeric functions:
  `min(), max(), abs(), floor(), ceil(), round()`

- Collection functions:
  `length(), contains(), keys(), values(), merge(), lookup(), distinct(), sort()`

- Encoding functions:
  `base64decode(), base64encode(), jsondecode(), jsonencode()`

- Date and time functions:
  `timestamp(), formatdate(), timeadd()`

- Filesystem functions:
  `file(), templatefile(), fileexists(), filebase64()`

- IP network functions:
  `cidrsubnet(), cidrsubnets(), cidrhost()`

- Type conversion functions:
  `tostring(), tonumber(), toset(), tolist(), tomap()`

---

### Terraform Console Examples

Experiment with the behavior of Terraform's built-in functions from the **Terraform Console**.

```bash
terraform console
```

```hcl
upper("Hello World") # -> "HELLO WORLD"
lower("Hello World") # -> "hello world"
trim(" Hello World "," ") # -> "Hello World"
replace("Hello World","World","Terraform") # -> "Hello Terraform"
substr("Hello World","0","5") # -> "Hello"

max(1,2,3) # -> 3
min(1,2,3) # -> 1
abs(-1) # -> 1

length([1,2,3,4]) # -> 4

concat([1,2],[3,4]) # -> [1,2,3,4]

merge({a=1},{b=2}) # -> {a=1,b=2}

toset([1,2,3,4,1]) # -> [1,2,3,4]
tonumber("20") # -> 20
tostring(20) # -> "20"

cidrsubnet("10.0.0.0/16", 8, 1) # -> "10.0.1.0/24"
cidrsubnets("10.0.0.0/16", 2, 2, 8, 8, 12, 12) # -> "10.0.0.0/18", "10.0.64.0/18", "10.0.128.0/24", "10.0.129.0/24", "10.0.130.0/28", "10.0.130.16.0/28"
cidrhost("10.0.16.0/20", 4000) # -> "10.0.31.160"

timestamp() # -> "2026-06-10T07:02:27Z"
formatdate("YYYY-MM-DD", timestamp()) # -> "2026-06-10"

```

---

### What This Project (10-functions) Does?

> The primary goal is to **demonstrate Terraform functions in practice.**

This project provisions the following AWS resources:

- **IAM Role & Instance Profile** (with S3 read-only policy attached)
- **EC2 instances** (deployed across multiple availability zones)
- **Security group** (with configurable ingress/egress rules)

State is stored remotely in an **S3 backend** with encryption and locking enabled (`dev.backend.hcl`).

This project demonstrates the usage of different functions such as:

- element()
- file()
- lower()
- replace()
- contains()
- alltrue()
- values()
- can()
- regex()
- fileexists()
- startswith()

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
