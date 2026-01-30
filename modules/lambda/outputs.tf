output "lambda_invoke_arn" {
  description = "Invoke ARN of the dictionary handler lambda function"
  value       = aws_lambda_function.dictionary_handler.invoke_arn
}

output "lambda_function_name" {
  description = "Name of the lambda function"
  value       = aws_lambda_function.dictionary_handler.function_name
}
