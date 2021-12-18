locals {
  cidr_block_main_list = split(",",var.cidr_block_main )
  cidr_block_all = concat(local.cidr_block_main_list,var.cidr_block_addon)
}

locals {
  application-list = ([
      for cidr in local.cidr_block_all:[
       for route_table in tolist(data.aws_route_tables.defaultroutes.ids) :{
       cidr = cidr
       route_table = route_table
  }
  ]
  ])
}
