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

variable "tags" {
  description = "Tags to apply to all VPC resources."
  default     = {}
  type        = map(any)
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(any)
}

variable "availability_zones" {
  description = "List of subnet availability zones."
  type        = list(string)
}

variable "expand_ephemeral_port_range" {
  description = "TCP and UDP ephemeral range will be adjusted to 1024-65535 in private subnets.  Required for Lambda, EKS, etc.  https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#nacl-ephemeral-ports"
  default     = false
  type        = bool
}

variable "flowlog_retention" {
  description = "Flowlog retention in days for CloudWatch log group."
  default     = 7
  type        = number
}

variable "domain_name" {
  description = "Domain Name"
  default     = "ec2.internal"
  type        = string
}

variable "domain_name_servers" {
  description = "List of the DNS servers"
  default     = ["AmazonProvidedDNS"]
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Single NAT Gateway for all AZs.  Provides cost savings in development environments."
  default     = false
  type        = bool
}

variable "ssm_vpc_endpoint" {
  description = "Enable SSM VPC Endpoint"
  default     = false
  type        = bool
}

variable "ecr_vpc_endpoint" {
  description = "Enable ECR VPC Endpoint"
  default     = false
  type        = bool
}

variable "ecs_vpc_endpoint" {
  description = "Enable ECS VPC Endpoint"
  default     = false
  type        = bool
}

variable "logs_vpc_endpoint" {
  description = "Enable Cloudwatch Logs VPC Endpoint"
  default     = false
  type        = bool
}

variable "ec2_vpc_endpoint" {
  description = "Enable EC2 VPC Endpoint"
  default     = false
  type        = bool
}

variable "api_execute_vpc_endpoint" {
  description = "Enable EC2 VPC Endpoint"
  default     = false
  type        = bool
}

variable "create_nat_gateway" {
  description = "Condition to create nat gateway default: true"
  default     = true
  type        = bool
}

variable "create_public_subnet" {
  description = "Condition to create nat gateway default: true"
  default     = true
  type        = bool
}

variable "create_private_subnet" {
  description = "Condition to create nat gateway default: true"
  default     = true
  type        = bool
}

variable "create_private_data_subnet" {
  description = "Condition to create nat gateway default: true"
  default     = true
  type        = bool
}

variable "nat_gateway_ids" {
  description = "Enter nat gateway ids in a list(string) format default: []"
  default     = []
  type        = list(string)
}
