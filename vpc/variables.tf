variable "vpc01_name" {
  description = "VPC Name"
}

variable "vpc01_cidr" {
  description = "Full VPC Network CIDR"
}

variable "availability_zones" {
  description = "List of subnet availability zones."
  type        = list(string)
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

variable "tags" {
  description = "Tags to apply to all VPC resources."
  default     = {}
  type        = map(any)
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(any)
}