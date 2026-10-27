output "primary_vpc_info" {
  description = "details of the Primary VPC"
  value = {
    id         = aws_vpc.primary.id
    arn        = aws_vpc.primary.arn
    cidr_block = aws_vpc.primary.cidr_block
  }
}

output "secondary_vpc_info" {
  description = "details of the Secondary VPC"
  value = {
    id         = aws_vpc.secondary.id
    arn        = aws_vpc.secondary.arn
    cidr_block = aws_vpc.secondary.cidr_block
  }
}

output "vpc_peering_connection_id" {
  description = "ID of the VPC Peering Connection"
  value       = aws_vpc_peering_connection.primary_to_secondary.id
}

output "vpc_peering_status" {
  description = "Status of the VPC Peering Connection"
  value       = aws_vpc_peering_connection.primary_to_secondary.accept_status
}

output "primary_instance_ip" {
  description = "Private & public IPs of the Primary EC2 Instance"
  value = {
    private_ip = aws_instance.primary.private_ip
    public_ip  = aws_instance.primary.public_ip
  }
}

output "secondary_instance_ip" {
  description = "Private & public IPs of the Secondary EC2 Instance"
  value = {
    private_ip = aws_instance.secondary.private_ip
    public_ip  = aws_instance.secondary.public_ip
  }
}