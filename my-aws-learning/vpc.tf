# default vpc
data "aws_vpc" "default-vpc" {
  default = true
}

# custom vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

# public subnets
resource "aws_subnet" "public-subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  availability_zone       = element(var.allowed_availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}_public-subnet-${count.index + 1}"
  }
}
