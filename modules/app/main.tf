# Connects to your GitHub repository where the React code lives
resource "aws_amplify_app" "dictionary_frontend" {
  name         = "cloud-dictionary-app"
  repository   = var.github_repo
  access_token = var.github_token

  enable_auto_branch_creation = true

  # Pass the API URL from Terraform to Amplify
  environment_variables = {
    REACT_APP_API_URL   = "${var.api_invoke_url}/search"
    AMPLIFY_DIFF_DEPLOY = "false"
    NODE_VERSION        = "20" # Forces Amplify to use Node 20
  }

  # Auto-build settings
  build_spec = file("${path.module}/amplify.yml")
}

# Declaration of Amplify branch configuration
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = "main"

  enable_auto_build = false

  # Optional: Framework hint helps Amplify environment setup
  framework = "React"
}

# Webhook to trigger from Terraform to Amplify
resource "aws_amplify_webhook" "build_webhook" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = aws_amplify_branch.main.branch_name
  description = "Triggered by Terraform Cloud"
}

# Null resource
resource "null_resource" "curl_webhook" {
  triggers = {
    always_run = timestamp()                                                           # This changes every single time you run terraform apply
    env_vars   = jsonencode(aws_amplify_app.dictionary_frontend.environment_variables) # Keep this so you can track if vars changed in the logs
  }

  provisioner "local-exec" {
    command = "curl -X POST -d {} '${aws_amplify_webhook.build_webhook.url}&operation=startbuild' -H 'Content-Type: application/json'"
  }
}
