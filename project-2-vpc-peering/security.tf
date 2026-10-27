# security group for the primary vpc EC2 instance
resource "aws_security_group" "primary" {
  name        = "${local.name_prefix}_primary"
  description = "primary vpc EC2 instance security group"
  vpc_id      = aws_vpc.primary.id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}_primary"
  }
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

  tags = {
    Name = "${local.name_prefix}_allow_all"
  }
}


# INGRESS rules for the secondary vpc security group
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

  tags = {
    Name = "${local.name_prefix}_allow_all"
  }
}