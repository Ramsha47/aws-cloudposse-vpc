# Define locals to dynamically gather CIDRs
locals {
  public_cidrs = [
    var.vpc01_public_cidr_az01,
    var.vpc01_public_cidr_az02,
    var.vpc01_public_cidr_az03,
  ]

  private_cidrs = [
    var.vpc01_private_cidr_az01,
    var.vpc01_private_cidr_az02,
    var.vpc01_private_cidr_az03,
  ]
}

# Dynamic Subnets Module
module "dynamic_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.0.0"  # Consider upgrading to a newer version if needed

  name               = var.vpc01_name
  vpc_id             = module.vpc01.vpc_id
  igw_id             = [module.vpc01.igw_id]
  ipv4_cidr_block    = [var.vpc01_cidr]
  availability_zones = var.availability_zones

  ipv4_cidrs = [
    {
      public  = local.public_cidrs
      private = local.private_cidrs
    }
  ]

  # Define subnet mappings
  private_subnets_enabled = true
  public_subnets_enabled  = true
  nat_gateway_enabled     = true  # Set to false if you don't need NAT

  additional_tag_map = {
    "Name"                            = "${var.vpc01_name}-subnet"
    "kubernetes.io/role/elb"          = "1"
    "kubernetes.io/role/internal-elb" = "1"
  }
  tags = var.common_tags

  # Route tables
  public_route_table_per_subnet_enabled = true
  private_route_table_enabled           = true

  # NACLs
  public_open_network_acl_enabled  = true
  private_open_network_acl_enabled = true
}