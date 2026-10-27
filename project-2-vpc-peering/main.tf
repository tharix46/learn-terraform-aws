# primary VPC
resource "aws_vpc" "primary" {
  cidr_block           = var.primary_vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

# secondary VPC
resource "aws_vpc" "secondary" {
  provider             = aws.secondary
  cidr_block           = var.secondary_vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

# primary vpc subnet
data "aws_availability_zones" "primary" {
  state = "available"
}

resource "aws_subnet" "primary" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = cidrsubnet(var.primary_vpc_cidr_block, 8, 1)
  availability_zone       = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public-subnet"
  }
}

# secondary vpc subnet
data "aws_availability_zones" "secondary" {
  provider = aws.secondary
  state    = "available"
}

resource "aws_subnet" "secondary" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.secondary.id
  cidr_block              = cidrsubnet(var.secondary_vpc_cidr_block, 8, 1)
  availability_zone       = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public-subnet"
  }
}

# primary vpc internet gateway
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_igw"
  }
}

# secondary vpc internet gateway
resource "aws_internet_gateway" "secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_igw"
  }
}

# VPC peering connection (requester side - Primary VPC)
resource "aws_vpc_peering_connection" "primary_to_secondary" {
  vpc_id      = aws_vpc.primary.id
  peer_vpc_id = aws_vpc.secondary.id
  peer_region = var.secondary_region
  auto_accept = false

  tags = {
    Name = "${local.name_prefix}_Primary-to-Secondary-Peering"
    Side = "Requester"
  }
}

# VPC peering connection accepter (accepter side - Secondary VPC)
resource "aws_vpc_peering_connection_accepter" "secondary_accepter" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id
  auto_accept               = true

  tags = {
    Name = "${local.name_prefix}_Secondary-Peering-Accepter"
    Side = "Accepter"
  }
}

# primary VPC route table
resource "aws_route_table" "primary" {
  vpc_id = aws_vpc.primary.id

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public"
  }
}

# secondary VPC route table
resource "aws_route_table" "secondary" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary.id

  #TODO: make these true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${local.name_prefix}_public"
  }
}
