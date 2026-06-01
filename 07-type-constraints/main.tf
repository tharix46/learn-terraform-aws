# EC2 instance
resource "aws_instance" "test-server" {
  ami                         = "ami-0a2b6680ef4ed0596"
  instance_type               = var.instance_type
  monitoring                  = var.monitoring
  associate_public_ip_address = var.associate_public_ip
  vpc_security_group_ids      = [aws_security_group.test-sg.id]
  count                       = var.instance_count

  root_block_device {
    volume_size = var.root_block_device_size
    volume_type = var.root_block_device_volume_type
  }

  tags = {
    Name = "${local.name_prefix}_test-server-${count.index + 1}"
  }
}

# security group for the EC2 instances
resource "aws_security_group" "test-sg" {
  name        = "${local.name_prefix}_test-sg"
  description = "Allow SSH & HTTP inbound traffic and all outbound traffic"

  tags = {
    Name = "${local.name_prefix}_test-sg"
  }
}

# ssh ingress rule for security group
resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.allowed_ingress_ports["ssh"]
  ip_protocol       = "tcp"
  to_port           = var.allowed_ingress_ports["ssh"]
}

# http ingress rule for security group
resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.allowed_ingress_ports["http"]
  ip_protocol       = "tcp"
  to_port           = var.allowed_ingress_ports["http"]
}

# all outbound traffic rule for security group
resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}