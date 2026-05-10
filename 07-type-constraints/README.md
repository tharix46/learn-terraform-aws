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

| Type | Description | Example |
| :--- | :--- | :--- |
| **string** | Text wrapped in double quotes. | `"t2.micro"` |
| **number** | Numeric values (integer or float). | `1` or `0.0123456` |
| **bool** | Boolean logic values. | `true` or `false` |

---

### Complex Types

- Has **multiple values**.
- Can be **homogeneous** _(all values are the same type)_. 
   _Example:_ `list(string)`, `set(string)`, `map(string)`
- Or **heterogeneous** _(values can be of different types)_.
   _Example:_ `tuple([string, number, bool])`, `object({ name = string, age = number, active = bool })`

---

### Collection Types (Homogeneous)

Groups of values of the **same data type**.

1. List
    - Ordered sequence of values.
    - Accessed by **index (starts at 0)**.
    - _Example:_ `["t2.micro", "t2.small", "t3.micro"]`  -> `var.list_name[0]`

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

### Structural Types (Heterogeneous)

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

### Other Important Notes

- **null**: Represents the absence of a value.
- **any**: A placeholder that lets Terraform determine the type (use sparingly).
- **Strict Typing**: If you define a type (e.g., `list(string)`), passing a `number` will trigger a validation error.

---

### Terraform Commands Used in This Folder

```bash
tf init -backend-config="dev.backend.hcl"
tf validate
tf fmt

tf plan -var-file="dev.tfvars"

tf apply -auto-approve -var-file="dev.tfvars"

tf destroy -auto-approve
```

---