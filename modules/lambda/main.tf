# Create a ZIP file of the python code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda/lambda_function.zip"
}

# The Lambda function retrieves the definition for a given search term.
resource "aws_lambda_function" "dictionary_handler" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "CloudDictionaryHandler"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "index.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout          = 60
  memory_size      = 128 # Minimum RAM (cheapest/free)

  tracing_config {
    mode = "Active"
  }

  dead_letter_config {
    target_arn = aws_sqs_queue.lambda_dlq.arn
  }

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

# Create the SQS Queue to act as the DLQ
resource "aws_sqs_queue" "lambda_dlq" {
  name                      = "CloudDictionary-DLQ"
  message_retention_seconds = 1209600 # 14 days
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "cloud_dictionary_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Policy to allow Lambda to read from DynamoDB
resource "aws_iam_role_policy" "lambda_dynamo_policy" {
  role = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["dynamodb:GetItem", "dynamodb:Query"]
      Resource = [var.dynamodb_table_arn]
    }]
  })
}

# Create the Log Group explicitly
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  # The name MUST match this exact pattern
  name              = "/aws/lambda/${aws_lambda_function.dictionary_handler.function_name}"
  retention_in_days = 7 # Automatically delete logs after 7 days to save money
}

# Update the Lambda's IAM Policy
# Ensure your Lambda role has the 'BasicExecutionRole' policy attached,
# or explicitly allow logging to this specific log group.
resource "aws_iam_role_policy" "lambda_logging" {
  name = "lambda_logging_policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "${aws_cloudwatch_log_group.lambda_log_group.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_sqs_policy" {
  name = "LambdaDLQPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sqs:SendMessage"
        Effect   = "Allow"
        Resource = aws_sqs_queue.lambda_dlq.arn
      }
    ]
  })
}
