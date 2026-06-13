# Trust Policy Document 
# a data block reads or generates information, but it does not create real infrastructure on AWS by itself
data "aws_iam_policy_document" "ec2_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM Role
# This uses the trust policy created above by using a reference to the data block
resource "aws_iam_role" "test-role" {
  name               = "${local.name_prefix}_test-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy.json
}

# Attach S3 read only access policy to the role (no attribute of this is referenced by EC2 resource below)
resource "aws_iam_role_policy_attachment" "s3_read_only_access" {
  role       = aws_iam_role.test-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Instance Profile
# This attaches the role to an instance profile which is then attached to EC2 instances
resource "aws_iam_instance_profile" "test-instance-profile" {
  name = "${local.name_prefix}_test-instance-profile"
  role = aws_iam_role.test-role.name
}

# EC2 instance that depends on the policy being attached
resource "aws_instance" "test-server" {
  ami                         = "ami-0a2b6680ef4ed0596"
  instance_type               = var.ec2_instance_types[var.environment]
  monitoring                  = var.ec2_monitoring
  associate_public_ip_address = var.ec2_associate_public_ip
  vpc_security_group_ids      = [aws_security_group.test-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.test-instance-profile.name
  count                       = var.ec2_instance_count

  root_block_device {
    volume_size = var.ec2_root_block_device_size
    volume_type = var.ec2_root_block_device_volume_type
  }

  user_data = file("${path.module}/userdata.sh")

  # Terraform knows about the instance_profile above (implicit dependency),
  # but it does NOT know the S3 policy must be attached before creating EC2 instances.
  # We make that dependency explicit here.
  depends_on = [
    aws_iam_role_policy_attachment.s3_read_only_access
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}_test-server-${count.index + 1}"
  }
}

# security group for the EC2 instances
resource "aws_security_group" "test-sg" {
  name        = "${local.name_prefix}_test-sg"
  description = "Allow SSH & HTTP inbound traffic and all outbound traffic"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.name_prefix}_test-sg"
  }
}

# ingress rules for the security group "test-sg"
resource "aws_vpc_security_group_ingress_rule" "allow-ingress" {
  for_each          = var.sg_allowed_ingress_ports
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value

  tags = {
    Name = "${local.name_prefix}_allow_${each.key}"
  }
}

# all outbound traffic rule for security group
resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}