# Expressions

### Conditional Expressions

Uses the ternary operator to evaluate a condition and return one of two values.

```hcl
condition ? true_value : false_value
```
```hcl
resource "aws_instance" "app-server" {
  ami           = "ami-12345678"
  # IF is_prod is true, use t3.large. ELSE use t2.micro.
  instance_type = var.is_prod ? "t3.large" : "t2.micro"
}
```

---

### Splat Expressions

Get a list of attributes from a collection of resources (usually created with count).

```hcl
resource.list[*].attribute
```

Example:

```hcl
resource "aws_instance" "app-servers" {
  count         = 3
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}

output "private_ips" {
  # returns a list of IPs: ["10.0.1.10", "10.0.2.10", "10.0.3.10"]
  value = aws_instance.app-servers[*].private_ip 
}
```

---

### Dynamic Blocks

A Dynamic Block acts like a for loop inside a resource block. 

It is used for "nested blocks" (configurations that repeat within a resource, like Security Group rules) to **create multiple nested blocks in one resource block.**

```hcl
dynamic "block_name" {
  for_each = var.collection_of_values
  content {
    # block configuration
    # in the content bloc`k, you can access the value using `block_name.value`
  }
}
```

Example:

```hcl
variable "allowed-ports" {
  type = list(number)
  default = [80, 443, 8080]
}

resource "aws_security_group" "allow_web" {
  name = "web-sg"

  dynamic "ingress" {
    for_each = var.allowed-ports  # loop through the list of ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

> `for_each` vs `dynamic` block:
> 
> - `for_each` loops over resources.
> - `dynamic` loops over sub-configurations inside a single resource. 

---