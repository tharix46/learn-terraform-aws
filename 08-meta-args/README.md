# Meta Arguments

Meta Arguments are special arguments **provided by the Terraform language** itself.
Unlike standard arguments that define specific properties of a resource, meta-arguments **control** how Terraform handles the **resource's infrastructure lifecycle, scaling, and dependencies**.

---

| Meta Argument  | Description                                     | Use Case                                                                                | Example                                      |
| :------------- | :---------------------------------------------- | :-------------------------------------------------------------------------------------- | :------------------------------------------- |
| **count**      | Creates multiple instances of a resource.       | Deploying multiple identical resources based on a condition.                            | `count = var.instance_count`                 |
| **for_each**   | Creates resources from a map or set of strings. | Deploying resources based on dynamic keys/values.                                       | `for_each = var.environments`                |
| **depends_on** | Explicitly defines resource dependencies.       | Controlling creation order when implicit dependencies cannot be automatically inferred. | `depends_on = [aws_vpc.main]`                |
| **provider**   | Specifies which provider to use for a resource. | Using different providers for different resources.                                      | `provider = aws.secondary`                   |
| **lifecycle**  | Controls resource lifecycle behavior.           | Skipping updates, preventing deletion, custom replacement.                              | `lifecycle { create_before_destroy = true }` |

---

### Expert Insight

In a real DevOps environment, `prevent_destroy` (within the lifecycle meta-argument) is your best friend for **stateful resources** (where data lives), while `create_before_destroy` (within the lifecycle meta-argument) is essential for **stateless resources** (like web servers).

---
