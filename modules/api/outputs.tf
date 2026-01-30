output "api_endpoint" {
  description = "The URL of the API Gateway stage"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/search"
}

output "api_invoke_url" {
  description = "The invoke URL of the API Gateway stage"
  value       = aws_api_gateway_stage.prod.invoke_url
}
