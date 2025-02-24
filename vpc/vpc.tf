module "vpc01" {
  source = "cloudposse/vpc/aws"
  version = "2.0.0" # Adjust this based on the latest version

  name                     = var.vpc01_name
  dns_hostnames_enabled    = true
  dns_support_enabled      = true
  internet_gateway_enabled = true
  ipv4_primary_cidr_block  = var.vpc01_cidr
  tags                     = var.common_tags
}