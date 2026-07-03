project                    = "my-aws-learning"
environment                = "dev"
region                     = "us-east-1"
iam_user_name              = "dev-user-1"
iam_group_name             = "devs"
allowed_availability_zones = ["us-east-1a", "us-east-1b"]
vpc_cidr_block             = "10.0.0.0/16"
public_subnet_configs = {
    "us-east-1a" = { az = "us-east-1a", new_bits = 8, net_num = 1 }
    "us-east-1b" = { az = "us-east-1b", new_bits = 8, net_num = 2 }
}
private_subnet_configs = {
  "app-us-east-1a" = { az = "us-east-1a", new_bits = 4, net_num = 1 }
  "app-us-east-1b" = { az = "us-east-1b", new_bits = 4, net_num = 2 }
  "db-us-east-1a"  = { az = "us-east-1a", new_bits = 4, net_num = 3 }
  "db-us-east-1b"  = { az = "us-east-1b", new_bits = 4, net_num = 4 }
}