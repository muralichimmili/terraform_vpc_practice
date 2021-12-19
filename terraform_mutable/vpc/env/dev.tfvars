ENV              = "dev"
cidr_block_main  = "10.0.0.0/16"
cidr_block_addon = ["10.255.0.0/24"]
private_subnets  = ["10.0.0.0/17","10.0.128.0/17"]
public_subnets   = ["10.255.0.0/25","10.255.0.128/25"]
azs              = ["us-east-1c","us-east-1d"]
default_vpc_id   = "vpc-02090e23b3c541df1"
cidr_block_default = "172.31.0.0/16"