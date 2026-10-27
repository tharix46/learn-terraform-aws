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