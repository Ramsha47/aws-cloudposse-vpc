module "vpc_endpoints" {
  source  = "cloudposse/vpc/aws//modules/vpc-endpoints"
  version = "2.0.0"

  vpc_id = module.vpc01.vpc_id

  # S3 & DynamoDB Gateway VPC Endpoints 
  gateway_vpc_endpoints = {
    "s3" = {
      name            = "s3"
      policy          = null
      route_table_ids = concat(
        module.dynamic_subnets.private_route_table_ids, 
        module.dynamic_subnets.public_route_table_ids
      )
    }
    "dynamodb" = {
      name            = "dynamodb"
      policy          = null
      route_table_ids = concat(
        module.dynamic_subnets.private_route_table_ids, 
        module.dynamic_subnets.public_route_table_ids
      )
    }
  }

  # VPC Interface Endpoints (Private Link) 
  interface_vpc_endpoints = merge(
    var.ssm_vpc_endpoint ? {
      "ssm" = {
        name                = "ssm"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ssm", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
    } : {},
    var.ecr_vpc_endpoint ? {
      "ecr.api" = {
        name                = "ecr.api"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ecr", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
      "ecr.dkr" = {
        name                = "ecr.dkr"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ecr", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
    } : {},
    var.ecs_vpc_endpoint ? {
      "ecs" = {
        name                = "ecs"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ecs", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
      "ecs-agent" = {
        name                = "ecs-agent"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ecs", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
      "ecs-telemetry" = {
        name                = "ecs-telemetry"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ecs", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
    } : {},
    var.ec2_vpc_endpoint ? {
      "ec2" = {
        name                = "ec2"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "ec2", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        policy              = null
        private_dns_enabled = true
      }
    } : {},
    var.api_execute_vpc_endpoint ? {
      "execute-api" = {
        name                = "execute-api"
        security_group_ids  = [lookup(module.vpc_endpoint_sgs, "api_gateway", null).id]
        subnet_ids          = module.dynamic_subnets.private_subnet_ids
        private_dns_enabled = true
      }
    } : {}
  )
}

# Locals block to define rules per service type
locals {
  sg_rules = {
    "ssm" = [],
    "ecr" = [{
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.vpc01_cidr
    }],
    "ecs" = [{
      type        = "ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = var.vpc01_cidr
    }],
    "ec2" = [{
      type        = "ingress"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = var.vpc01_cidr
    }],
    "api_gateway" = [
      {
        type        = "ingress"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        type        = "egress"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

# SECURITY GROUPS FOR INTERFACE ENDPOINTS WITH FIXED RULES
module "vpc_endpoint_sgs" {
  source  = "cloudposse/security-group/aws"
  version = "2.0.0"

  for_each = {
    ssm          = var.ssm_vpc_endpoint
    ecr          = var.ecr_vpc_endpoint
    ecs          = var.ecs_vpc_endpoint
    ec2          = var.ec2_vpc_endpoint
    api_gateway  = var.api_execute_vpc_endpoint
  }

  enabled = each.value
  vpc_id  = module.vpc01.vpc_id
  name    = "vpc-endpoint-${each.key}"

  # Apply only the rules specific to this security group
  rules_map = {
    "rules" = lookup(local.sg_rules, each.key, [])
  }

  allow_all_egress = false
}