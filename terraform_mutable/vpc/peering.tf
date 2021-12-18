resource "aws_vpc_peering_connection" "peering" {

  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = var.default_vpc_id
  auto_accept   = true
  tags = {

    Name = "${var.ENV}-vpv-to-default-vpc"

  }

}