# Terraform Functions

In Terraform, Functions are built-in tools used to **transform data, manipulate strings, manage collections, and validate inputs dynamically during execution.**
Unlike general programming languages (Python/Go), you cannot create your own custom functions in Terraform.
You can only use the ones provided by Terraform.

---

### Different Types of Functions

- String functions
- Numeric functions
- Collection functions
- Encoding functions
- Date and time functions
- Filesystem functions
- IP network functions
- Type conversion functions

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
cidrhost("10.0.16.0/20", 4000) # -> "10.0.31.160"

timestamp() # -> "2026-06-10T07:02:27Z"
formatdate("YYYY-MM-DD", timestamp()) # -> "2026-06-10"

```

---
