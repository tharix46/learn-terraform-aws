# default vpc
data "aws_vpc" "default-vpc" {
  default = true
}

# custom vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

# public subnets
resource "aws_subnet" "public-subnets" {
  count = 2
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(var.allowed_availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}_public-subnet-${count.index + 1}"
  }
}
