variable "aws_region" {
  description = "Terraform deployment region"
}

variable "availability_zones" {
  description = "Availability Zones to use in the operating region"
}

variable "vpc01_name" {
  description = "VPC Name"
}

variable "vpc01_cidr" {
  description = "Full VPC Network CIDR"
}

variable "vpc01_public_cidr_az01" {
  description = "CIDRs for public subnets in AZ01"
}

variable "vpc01_private_cidr_az01" {
  description = "CIDRs for private subnets in AZ01"
}

variable "vpc01_public_cidr_az02" {
  description = "CIDRs for public subnets in AZ02"
}

variable "vpc01_private_cidr_az02" {
  description = "CIDRs for private subnets in AZ02"
}

variable "vpc01_public_cidr_az03" {
  description = "CIDRs for public subnets in AZ03"
}

variable "vpc01_private_cidr_az03" {
  description = "CIDRs for private subnets in AZ03"
}

variable "vpc01_data_cidr_az03" {
  description = "CIDRs for data subnets in AZ03"
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(any)
}