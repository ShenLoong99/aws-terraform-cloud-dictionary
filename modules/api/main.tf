# This acts as the bridge between the React app and the Lambda.
resource "aws_api_gateway_rest_api" "dictionary_api" {
  name = "CloudDictionaryAPI"
  lifecycle {
    create_before_destroy = true
  }
}

# Create the Request Validator
resource "aws_api_gateway_request_validator" "dictionary_validator" {
  name                        = "search-validator"
  rest_api_id                 = aws_api_gateway_rest_api.dictionary_api.id
  validate_request_parameters = true
}

# Search gateway resource
resource "aws_api_gateway_resource" "search" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  parent_id   = aws_api_gateway_rest_api.dictionary_api.root_resource_id
  path_part   = "search"
}

# Get term gateway method
resource "aws_api_gateway_method" "get_term" {
  rest_api_id          = aws_api_gateway_rest_api.dictionary_api.id
  resource_id          = aws_api_gateway_resource.search.id
  http_method          = "GET"
  authorization        = "NONE" # checkov:skip=CKV_AWS_59:Public search endpoint intended for portfolio access
  request_validator_id = aws_api_gateway_request_validator.dictionary_validator.id

  request_parameters = {
    "method.request.querystring.term" = true # Ensures 'term' is present
  }
}

# API gateway integrate with lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.get_term.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# lambda permission
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.dictionary_api.execution_arn}/*/*"
}

# API gateway deployment
resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  description = "Deployed via Terraform on ${timestamp()}"

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_integration.lambda_integration))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# API gateway stage
resource "aws_api_gateway_stage" "prod" {
  deployment_id        = aws_api_gateway_deployment.prod.id
  rest_api_id          = aws_api_gateway_rest_api.dictionary_api.id
  stage_name           = "prod"
  xray_tracing_enabled = true
}

# Enable Logging (Fixes CKV2_AWS_4)
resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  stage_name  = aws_api_gateway_stage.prod.stage_name
  method_path = "*/*"

  settings {
    logging_level      = "INFO"
    data_trace_enabled = false
    metrics_enabled    = true
  }
}
