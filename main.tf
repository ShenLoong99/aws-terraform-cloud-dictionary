# local common tags
locals {
  common_tags = {
    Project     = "CloudDictionary"
    Environment = "Prod"
    ManagedBy   = "Terraform"
    OwnedBy     = "ShenLoong"
  }
}

# API Gateway configuration module
module "api" {
  source               = "./modules/api"
  default_tags         = local.common_tags
  aws_region           = var.aws_region
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
}

# Amplify configuration module
module "app" {
  source         = "./modules/app"
  github_token   = var.github_token
  default_tags   = local.common_tags
  aws_region     = var.aws_region
  api_invoke_url = module.api.api_invoke_url
}

# DynamoDB configuration module
module "database" {
  source       = "./modules/database"
  default_tags = local.common_tags
  aws_region   = var.aws_region
}

# Lambda configuration module
module "lambda" {
  source              = "./modules/lambda"
  default_tags        = local.common_tags
  aws_region          = var.aws_region
  dynamodb_table_name = module.database.dynamodb_table_name
  dynamodb_table_arn  = module.database.dynamodb_table_arn
}
