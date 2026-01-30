variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  description = "Extra tags to pass to the provider"
  type        = map(string)
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the dictionary handler lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the lambda function"
  type        = string
}
