# Connects to your GitHub repository where the React code lives
resource "aws_amplify_app" "dictionary_frontend" {
  name         = "cloud-dictionary-app"
  repository   = var.github_repo
  access_token = var.github_token

  # Pass the API URL from Terraform to Amplify
  environment_variables = {
    REACT_APP_API_URL   = "${aws_api_gateway_stage.prod.invoke_url}/search"
    AMPLIFY_DIFF_DEPLOY = "false"
    NODE_VERSION        = "20" # Forces Amplify to use Node 20
  }

  # Auto-build settings
  build_spec = file("amplify.yml")
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = "main"

  enable_auto_build = true

  # Optional: Framework hint helps Amplify environment setup
  framework = "React"
}

resource "aws_amplify_webhook" "build_webhook" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = aws_amplify_branch.main.branch_name
  description = "Triggered by Terraform Cloud"
}

resource "null_resource" "curl_webhook" {
  triggers = {
    api_url = aws_api_gateway_stage.prod.invoke_url
  }

  provisioner "local-exec" {
    command = "curl -X POST -d {} '${aws_amplify_webhook.build_webhook.url}'"
  }
}