### Terraform Commands Used in This Project

```bash
tf init
tf validate
tf fmt
tf plan -var-file="dev.tfvars"
tf apply -var-file="dev.tfvars" -auto-approve

tf providers lock --platform=linux_amd64
```

### AWS CLI Commands Used in This Project

```bash
# list users
aws iam list-users --query "Users[*].[Name,ARN,CreateDate]" --output table

# get newly created user
aws iam get-user --user-name cli-user

# list groups
aws iam list-groups --query "Groups[*].[GroupName, CreateDate]"

# get newly created group
aws iam get-group --group-name cli-group

# list groups for user
aws iam list-groups-for-user --user-name cli-user
```
