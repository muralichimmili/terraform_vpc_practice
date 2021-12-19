resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route = [
    {
    cidr_block = var.cidr_block_default
    vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
    egress_only_gateway_id = ""
    transit_gateway_id = ""
    ipv6_cidr_block = ""
    network_interface_id = ""
    gateway_id = ""
    nat_gateway_id = ""
    instance_id = ""
  },
    {
      cidr_block = "0.0.0.0/0"
      vpc_peering_connection_id = ""
      egress_only_gateway_id = ""
      transit_gateway_id = ""
      ipv6_cidr_block = ""
      network_interface_id = ""
      gateway_id = ""
      nat_gateway_id = aws_nat_gateway.ngw.id
      instance_id = ""
    }
  ]
  tags = {
    Name = "private routetable"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route  = [

    {
      cidr_block = var.cidr_block_default
      vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
      egress_only_gateway_id = ""
      transit_gateway_id = ""
      ipv6_cidr_block = ""
      network_interface_id = ""
      gateway_id = ""
      nat_gateway_id = ""
      instance_id = ""
    },
    {
      cidr_block = "0.0.0.0/0"
      vpc_peering_connection_id = ""
      egress_only_gateway_id = ""
      transit_gateway_id = ""
      ipv6_cidr_block = ""
      network_interface_id = ""
      gateway_id =aws_internet_gateway.igw.id
      nat_gateway_id = ""
      instance_id = ""
    }

]



  }

  tags = {
    Name = "public routetable"
  }
}

resource "aws_route" "route-from-default-vpc" {
  count                     = length(local.association-list)
  route_table_id            = tomap(element(local.association-list, count.index))["route_table"]
  destination_cidr_block    = tomap(element(local.association-list, count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

data "aws_route_tables" "defaultroutes" {
  vpc_id = var.default_vpc_id
}

