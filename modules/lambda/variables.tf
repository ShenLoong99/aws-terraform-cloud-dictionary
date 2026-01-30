variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  description = "Extra tags to pass to the provider"
  type        = map(string)
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB dictionary table"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB dictionary table"
  type        = string
}
