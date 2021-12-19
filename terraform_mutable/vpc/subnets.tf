resource "aws_subnet" "private_subnets" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
  count = length(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.private_subnets,count.index )
  availability_zone = element(var.azs,count.index )

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public_subnets" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
  count = length(var.public_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.public_subnets,count.index )
  availability_zone = element(var.azs,count.index )

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "private_ra" {
  count = length(aws_subnet.private_subnets.*.id)
  subnet_id      = element(aws_subnet.private_subnets.*.id,count.index )
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "public_ra" {
  count = length(aws_subnet.public_subnets.*.id)
  subnet_id      = element(aws_subnet.public_subnets.*.id,count.index )
  route_table_id = aws_route_table.public_rt.id
}