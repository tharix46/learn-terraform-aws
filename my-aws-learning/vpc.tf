# default vpc
data "aws_vpc" "default-vpc" {
  default = true
}

# custom vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  lifecycle {
    prevent_destroy = true
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
    prevent_destroy = true
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
    prevent_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}_private-subnet-${each.key}"
  }
}

# internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "${local.name_prefix}_igw"
  }
}

# public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

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