provider "aws" {
  region  = var.aws_region
}

module "vpc" {
  source                   = "./vpc"
  availability_zones       = var.availability_zones
  common_tags              = var.common_tags
  vpc01_name               = var.vpc01_name
  vpc01_cidr               = var.vpc01_cidr
  vpc01_public_cidr_az01   = var.vpc01_public_cidr_az01
  vpc01_private_cidr_az01  = var.vpc01_private_cidr_az01
  vpc01_public_cidr_az02   = var.vpc01_public_cidr_az02
  vpc01_private_cidr_az02  = var.vpc01_private_cidr_az02
  vpc01_public_cidr_az03   = var.vpc01_public_cidr_az03
  vpc01_private_cidr_az03  = var.vpc01_private_cidr_az03  
}