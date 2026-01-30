output "api_endpoint" {
  description = "The URL of the API Gateway stage"
  value       = module.api.api_endpoint
}

output "amplify_app_url" {
  description = "The URL of the hosted React application"
  # This combines the branch name and the default generated domain
  value = module.app.amplify_app_url
}

output "api_invoke_url" {
  description = "The invoke URL of the API Gateway stage"
  value       = module.api.api_invoke_url
}

output "amplify_app_id" {
  description = "ID of the Amplify App"
  value       = module.app.amplify_app_id
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB dictionary table"
  value       = module.database.dynamodb_table_name
}

output "aws_region" {
  description = "The AWS region to deploy resources in"
  value       = var.aws_region
}
