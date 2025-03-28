# IAM Role for VPC Flow Logs
module "flowlogs_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.18.0"

  name = "flowlogs-test}"
  path = "/"
  role_description  = "IAM role for VPC Flow Logs to publish to CloudWatch Logs"

  # Define the assume role policy for vpc-flow-logs.amazonaws.com
  principals = {
    Service = ["vpc-flow-logs.amazonaws.com"]
  }

  policy_documents = [
    jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:logs:*:*:log-group:/aws/flowlogs/*"
        }
      ]
    })
  ]
}

# CloudWatch Log Group for VPC Flow Logs
module "flowlogs_log_group" {
  source  = "cloudposse/cloudwatch-logs/aws"
  version = "0.6.7"

  name              = "/aws/flowlogs/test"
  retention_in_days = var.flowlog_retention
  tags              = var.tags
}

# VPC Flow Logs
resource "aws_flow_log" "vpc_flowlogs" {
  vpc_id          = module.vpc01.vpc_id
  log_destination = module.flowlogs_log_group.log_group_arn
  traffic_type    = var.flowlog_traffic_type
  log_destination_type = "cloud-watch-logs"
  iam_role_arn    = module.flowlogs_role.arn
  tags = var.tags
}