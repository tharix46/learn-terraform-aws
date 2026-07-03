project                    = "my-aws-learning"
environment                = "dev"
region                     = "us-east-1"
iam_user_name              = "dev-user-1"
iam_group_name             = "devs"
allowed_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_cidr_block             = "10.0.0.0/16"
public_subnet_configs = {
  "us-east-1a" = 1
  "us-east-1b" = 2
}
private_subnet_configs = {
  "us-east-1a" = 1  
  "us-east-1b" = 2
}