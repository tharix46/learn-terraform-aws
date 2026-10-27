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

# route table association with primary vpc subnet
resource "aws_route_table_association" "primary" {
  subnet_id      = aws_subnet.primary.id
  route_table_id = aws_route_table.primary.id
}

# route table association with secondary vpc subnet
resource "aws_route_table_association" "secondary" {
  provider       = aws.secondary
  subnet_id      = aws_subnet.secondary.id
  route_table_id = aws_route_table.secondary.id
}

# default route for primary vpc subnet route table
resource "aws_route" "default_route_primary" {
  route_table_id         = aws_route_table.primary.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

# default route for secondary vpc subnet route table
resource "aws_route" "default_route_secondary" {
  provider               = aws.secondary
  route_table_id         = aws_route_table.secondary.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.secondary.id
}

# route to Secondary VPC in primary route table
resource "aws_route" "primary_to_secondary" {
  route_table_id            = aws_route_table.primary.id
  destination_cidr_block    = var.secondary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}

# route to Primary VPC in secondary route table
resource "aws_route" "secondary_to_primary" {
  provider                  = aws.secondary
  route_table_id            = aws_route_table.secondary.id
  destination_cidr_block    = var.primary_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}

# security group for the primary vpc EC2 instance
resource "aws_security_group" "primary" {
  name        = local.name_prefix
  description = "primary vpc EC2 instance security group"
  vpc_id      = aws_vpc.primary.id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}"
  }
}

# INGRESS rules for the primary vpc security group
# allow ssh access from anywhere
resource "aws_vpc_security_group_ingress_rule" "primary_allow-ssh" {
  security_group_id = aws_security_group.primary.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "${local.name_prefix}_allow_ssh"
  }
}

# allow ICMP from secondary VPC
resource "aws_vpc_security_group_ingress_rule" "primary_allow-icmp" {
  security_group_id = aws_security_group.primary.id
  cidr_ipv4         = var.secondary_vpc_cidr_block
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1

  tags = {
    Name = "${local.name_prefix}_allow_icmp"
  }
}

# EGRESS rules for the primary vpc security group
# all outbound all traffic 
resource "aws_vpc_security_group_egress_rule" "primary_allow-all" {
  security_group_id = aws_security_group.primary.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# security group for the secondary vpc EC2 instance
resource "aws_security_group" "secondary" {
  provider    = aws.secondary
  name        = "${local.name_prefix}_secondary"
  description = "secondary vpc EC2 instance security group"
  vpc_id      = aws_vpc.secondary.id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}_secondary"
  }
}

# ingress rules for the secondary vpc security group
# allow ssh access from anywhere
resource "aws_vpc_security_group_ingress_rule" "secondary_allow-ssh" {
  provider          = aws.secondary
  security_group_id = aws_security_group.secondary.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "${local.name_prefix}_allow_ssh"
  }
}

# allow ICMP from primary VPC
resource "aws_vpc_security_group_ingress_rule" "secondary_allow-icmp" {
  provider          = aws.secondary
  security_group_id = aws_security_group.secondary.id
  cidr_ipv4         = var.primary_vpc_cidr_block
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1

  tags = {
    Name = "${local.name_prefix}_allow_icmp"
  }
}

# EGRESS rules for the secondary vpc security group
# all outbound traffic rule for security group
resource "aws_vpc_security_group_egress_rule" "secondary_allow-all" {
  provider          = aws.secondary
  security_group_id = aws_security_group.secondary.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ec2 instance in primary vpc
data "aws_ami" "primary" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "primary" {
  ami                    = data.aws_ami.primary.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.primary.id
  vpc_security_group_ids = [aws_security_group.primary.id]
  key_name               = var.primary_key_name

  tags = {
    Name = "${local.name_prefix}_primary"
  }

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}


# ec2 instance in secondary vpc
data "aws_ami" "secondary" {
  provider    = aws.secondary
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "secondary" {
  provider               = aws.secondary
  ami                    = data.aws_ami.secondary.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.secondary.id
  vpc_security_group_ids = [aws_security_group.secondary.id]
  key_name               = var.secondary_key_name

  tags = {
    Name = "${local.name_prefix}_secondary"
  }

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}