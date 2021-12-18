resource "aws_subnet" "main" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
  count = length(var.subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.subnets,count.index )
  availability_zone = element(var.azs,count.index )

  tags = {
    Name = "subset-${count.index}"
  }
}