output "region" {
  description = "region of the ec2 instances"
  value       = aws_instance.test-server[*].region
}

output "environment" {
  description = "environment of the ec2 instances"
  value       = aws_instance.test-server[*].tags_all.Environment
}

output "instance_count" {
  description = "number of ec2 instances to create"
  value       = var.instance_count
}

output "instance_identifiers" {
  description = "IDs and ARNs of the ec2 instances"
  value = {
    id  = aws_instance.test-server[*].id
    arn = aws_instance.test-server[*].arn
  }
}

output "instance_types" {
  description = "types of the ec2 instances"
  value       = aws_instance.test-server[*].instance_type
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instances"
  value       = aws_instance.test-server[*].public_ip
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instances"
  value       = aws_instance.test-server[*].private_ip
}

output "ec2_root_volume_info" {
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

output "ec2_tags_all" {
  description = "all tags of the ec2 instances"
  value       = aws_instance.test-server[*].tags_all
}

output "sg_tags_all" {
  description = "all tags of the security group"
  value       = aws_security_group.test-sg.tags_all
}