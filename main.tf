# API Gateway configuration module
module "api" {
  source               = "./modules/api"
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
  depends_on           = [aws_api_gateway_account.main]
}

# Amplify configuration module
module "app" {
  source         = "./modules/app"
  github_token   = var.github_token
  api_invoke_url = module.api.api_invoke_url
}

# DynamoDB configuration module
module "database" {
  source = "./modules/database"
}

# Lambda configuration module
module "lambda" {
  source              = "./modules/lambda"
  dynamodb_table_name = module.database.dynamodb_table_name
  dynamodb_table_arn  = module.database.dynamodb_table_arn
}

# Create the IAM Role for API Gateway Logging
resource "aws_iam_role" "api_gateway_logging" {
  name = "APIGatewayCloudWatchLogsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}

# Attach the AWS Managed Policy for API Gateway Logging
resource "aws_iam_role_policy_attachment" "api_gateway_logging" {
  role       = aws_iam_role.api_gateway_logging.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

# Register the Role ARN in API Gateway Account Settings
resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_logging.arn
}
