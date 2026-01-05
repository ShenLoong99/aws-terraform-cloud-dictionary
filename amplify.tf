# Connects to your GitHub repository where the React code lives
resource "aws_amplify_app" "dictionary_frontend" {
  name         = "cloud-dictionary-app"
  repository   = var.github_repo
  access_token = var.github_token

  # Auto-build settings
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = "main"
}