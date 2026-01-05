# Connects to your GitHub repository where the React code lives
resource "aws_amplify_app" "dictionary_frontend" {
  name         = "cloud-dictionary-app"
  repository   = var.github_repo
  access_token = var.github_token

  # Pass the API URL from Terraform to Amplify
  environment_variables = {
    REACT_APP_API_URL = "${aws_api_gateway_stage.prod.invoke_url}/search"
    AMPLIFY_DIFF_DEPLOY = "false"
    NODE_VERSION = "20" # Forces Amplify to use Node 20
  }

  # Auto-build settings
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - cd frontend
            - npm install --no-audit --no-fund --loglevel=error
        build:
          commands:
            - echo "REACT_APP_API_URL=$REACT_APP_API_URL" >> .env
            - npm run build
      artifacts:
        baseDirectory: frontend/build
        files:
          - '**/*'
      cache:
        paths:
          - frontend/node_modules/**/*
  EOT
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = "main"

  # Optional: Framework hint helps Amplify environment setup
  framework = "React"
}