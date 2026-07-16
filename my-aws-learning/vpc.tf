# default vpc
data "aws_vpc" "default-vpc" {
  default = true
}

# custom vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

# public subnets
resource "aws_subnet" "public-subnets" {
  for_each                = var.public_subnet_configs
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, each.value.new_bits, each.value.net_num)
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public-subnet-${each.key}"
  }
}

# private subnets
resource "aws_subnet" "private-subnets" {
  for_each                = var.private_subnet_configs
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, each.value.new_bits, each.value.net_num)
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_private-subnet-${each.key}"
  }
}

# internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_igw"
  }
}

# public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public-route-table"
  }
}

# default route for public route table
resource "aws_route" "public-subnet-default-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-igw.id
}

# route table association with public subnets
resource "aws_route_table_association" "public-route-table-association" {
  for_each       = var.public_subnet_configs
  subnet_id      = aws_subnet.public-subnets[each.key].id
  route_table_id = aws_route_table.public-route-table.id
}

# # elastic ips for nat gateways
# resource "aws_eip" "nat-gw" {
#   for_each = var.public_subnet_configs
#   domain   = "vpc"

#   tags = {
#     Name = "${local.name_prefix}_nat-gw-eip_${each.key}"
#   }
# }

# # nat gateways
# resource "aws_nat_gateway" "nat-gw" {
#   for_each      = var.public_subnet_configs
#   allocation_id = aws_eip.nat-gw[each.key].id
#   subnet_id     = aws_subnet.public-subnets[each.key].id

#   depends_on = [aws_internet_gateway.dev-igw]

#   tags = {
#     Name = "${local.name_prefix}_nat-gw_${each.key}"
#   }
# }