# This acts as the bridge between the React app and the Lambda.
resource "aws_api_gateway_rest_api" "dictionary_api" {
  name = "CloudDictionaryAPI"
}

resource "aws_api_gateway_resource" "search" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  parent_id   = aws_api_gateway_rest_api.dictionary_api.root_resource_id
  path_part   = "search"
}

resource "aws_api_gateway_method" "get_term" {
  rest_api_id   = aws_api_gateway_rest_api.dictionary_api.id
  resource_id   = aws_api_gateway_resource.search.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.get_term.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.dictionary_handler.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dictionary_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.dictionary_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.dictionary_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_integration.lambda_integration))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.prod.id
  rest_api_id   = aws_api_gateway_rest_api.dictionary_api.id
  stage_name    = "prod"
}