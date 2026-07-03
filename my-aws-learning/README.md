### Terraform Commands Used in This Project

```bash
tf init
tf validate
tf fmt
tf plan -var-file="dev.tfvars"
tf apply -var-file="dev.tfvars" -auto-approve

# brew install graphviz
tf graph | dot -Tsvg > graph.svg

tf providers lock --platform=linux_amd64
```

### AWS CLI Commands Used in This Project

```bash
# list users
aws iam list-users --query "Users[*].[Name,ARN,CreateDate]" --output table

# get newly created user
aws iam get-user --user-name dev-user-1

# list groups
aws iam list-groups --query "Groups[*].[GroupName, CreateDate]"

# get newly created group
aws iam get-group --group-name devs

# list groups for user
aws iam list-groups-for-user --user-name dev-user-1
```

```bash
# list vpcs
aws ec2 describe-vpcs --query "Vpcs[*].[OwnerId, VpcId, Tags[?Key=='Name'].Value | [0]]" --output table

# list subnets
aws ec2 describe-subnets \
  --filter "Name=vpc-id, Values=vpc-0c462469acfaa2a51" \
  --query "Subnets[*].[SubnetId, Tags[?Key=='Name'].Value | [0], State, CidrBlock, AvailabilityZone]" \
  --output table

# list private subnets
aws ec2 describe-subnets \
  --filter "Name=vpc-id, Values=vpc-0c462469acfaa2a51" \
  --filter "Name=map-public-ip-on-launch, Values=false" \
  --query "Subnets[*].[SubnetId, Tags[?Key=='Name'].Value | [0], State, CidrBlock, AvailabilityZone]" \
  --output table

```
