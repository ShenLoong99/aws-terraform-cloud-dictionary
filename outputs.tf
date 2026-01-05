output "api_endpoint" {
  description = "The URL of the API Gateway stage"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/search"
}

output "amplify_app_url" {
  description = "The URL of the hosted React application"
  # This combines the branch name and the default generated domain
  value = "https://${aws_amplify_branch.main.branch_name}.${aws_amplify_app.dictionary_frontend.default_domain}"
}

output "amplify_app_id" {
  value = aws_amplify_app.dictionary_frontend.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dictionary_table.name
}