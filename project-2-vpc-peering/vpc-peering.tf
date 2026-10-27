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