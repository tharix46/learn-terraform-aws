output "role_info" {
  description = "details of the test-role"
  value = {
    id          = aws_iam_role.test-role.id
    arn         = aws_iam_role.test-role.arn
    create_date = aws_iam_role.test-role.create_date
  }
}

output "ec2_instance_region" {
  description = "region of the ec2 instances"
  value       = aws_instance.test-server[*].region
}

output "ec2_instance_environment" {
  description = "environment of the ec2 instances"
  value       = aws_instance.test-server[*].tags_all.Environment
}

output "ec2_instance_count" {
  description = "number of ec2 instances to create"
  value       = var.instance_count
}

output "ec2_instance_identifiers" {
  description = "IDs and ARNs of the ec2 instances"
  value = {
    id  = aws_instance.test-server[*].id
    arn = aws_instance.test-server[*].arn
  }
}

output "ec2_instance_types" {
  description = "types of the ec2 instances"
  value       = aws_instance.test-server[*].instance_type
}

output "ec2_instance_profiles" {
  description = "instance profiles of the ec2 instances"
  value       = aws_instance.test-server[*].iam_instance_profile
}

output "ec2_instance_public_ip" {
  description = "Public IP of the EC2 instances"
  value       = aws_instance.test-server[*].public_ip
}

output "ec2_instance_private_ip" {
  description = "Private IP of the EC2 instances"
  value       = aws_instance.test-server[*].private_ip
}

output "ec2_root_volume_sizes" {
  description = "Size and type of the root block device"
  value = {
    size = aws_instance.test-server[*].root_block_device[0].volume_size
    type = aws_instance.test-server[*].root_block_device[0].volume_type
  }
}

output "security_group_info" {
  description = "ID and name of the security group"
  value = {
    id   = aws_security_group.test-sg.id
    name = aws_security_group.test-sg.name
  }
}

output "role_tags_all" {
  description = "all tags of the role"
  value       = aws_iam_role.test-role.tags_all
}

output "ec2_tags_all" {
  description = "all tags of the ec2 instances"
  value       = aws_instance.test-server[*].tags_all
}

output "sg_tags_all" {
  description = "all tags of the security group"
  value       = aws_security_group.test-sg.tags_all
}