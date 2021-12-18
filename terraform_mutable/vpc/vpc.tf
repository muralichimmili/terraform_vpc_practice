resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_main

  tags = {
    Name = var.ENV
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count = length(var.cidr_block_addon)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.cidr_block_addon,count.index )
}


