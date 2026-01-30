output "dynamodb_table_name" {
  description = "Name of the DynamoDB dictionary table"
  value       = aws_dynamodb_table.dictionary_table.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB dictionary table"
  value       = aws_dynamodb_table.dictionary_table.arn
}
