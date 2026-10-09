# Type Constraints

We can categorize variables:

1. **Based on Purpose**
   - Input variables
   - Output variables
   - Local variables

2. **Based on Value _(Type Constraints)_**
   - Primitive types
     - String
     - Number
     - Boolean
   - Complex types
     - List
     - Map
     - Object
     - Tuple
     - Set

---

### Primitive Types

Simple, single-value data types.

| Type       | Description                        | Example            |
| :--------- | :--------------------------------- | :----------------- |
| **string** | Text wrapped in double quotes.     | `"t2.micro"`       |
| **number** | Numeric values (integer or float). | `1` or `0.0123456` |
| **bool**   | Boolean logic values.              | `true` or `false`  |

---

### Complex Types

- Has **multiple values**.
- Can be **homogeneous** _(all values are the same type)_.
  _Example:_ `list(string)`, `set(string)`, `map(string)`
- Or **heterogeneous** _(values can be of different types)_.
  _Example:_ `tuple([string, number, bool])`, `object({ name = string, age = number, active = bool })`

---

### Homogeneous

Groups of values of the **same data type**.

1. List
   - Ordered sequence of values.
   - Accessed by **index (starts at 0)**.
   - _Example:_ `["t2.micro", "t2.small", "t3.micro"]` -> `var.list_name[0]`

2. Set
   - Unordered collection of unique values.
   - Automatically removes duplicates.
   - Cannot be accessed by index directly. Use `tolist(var.set_name)[0]` if needed
   - _Example:_ `["us-east-1a", "us-east-1b", "us-east-1c"]` -> `tolist(var.set_name)[0]`

3. Map
   - Key-value pairs where **keys are always strings** and **values must all be the same type**.
   - can be accessed using `var.map_name["key"]`
   - _Example:_

```hcl
{
    Name = "web-server"
    Env = "Dev"
    Project = "tf-demo"
}
```

---

### Heterogeneous

Complex structures that can hold **different data types**.

1. Tuple
   - Fixed-length, ordered sequence.
   - Supports different types in a specific position.
   - _Example:_ `[80, "TCP", true]` -> `var.tuple_name[0]`

2. Object
   - Collection of named attributes with different types.
   - Best for complex resource configurations.
   - can be accessed using `var.object_name["key"]`
   - _Example:_

```hcl
{
    instance_type = "t2.micro"
    instance_count = 1
    monitoring = true
}
```

---

### What This Project (07-type-constraints) Does?

> The primary goal is to **demonstrate Terraform type constraints in practice.**

This project provisions the following AWS resources:

- **EC2 instance** (`t3.micro`, `us-east-1`, 8 GB `gp3` root volume)
- **Security group** with two ingress rules (SSH on port 22, HTTP on port 80) and a catch-all egress rule

All resources are automatically tagged with:

- `Project`
- `Environment`
- `CreatedBy`
- `ManagedBy`

via the provider-level `default_tags` block.

A `locals` block builds a consistent `name_prefix` that is used for every resource name.

State is stored remotely in an **S3 backend** with encryption and locking enabled (`dev.backend.hcl`).

---

### Terraform Commands Used in This Folder

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
