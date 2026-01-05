# Connects to your GitHub repository where the React code lives
resource "aws_amplify_app" "dictionary_frontend" {
  name         = "cloud-dictionary-app"
  repository   = var.github_repo
  access_token = var.github_token

  # Ensure the app itself doesn't try to auto-create and build branches
  enable_branch_auto_build = false

  # Auto-build settings
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - cd frontend
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
          - frontend/node_modules/**/*
  EOT
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.dictionary_frontend.id
  branch_name = "main"

  # DISABLE AUTO BUILD HERE
  enable_auto_build = false

  # Optional: Framework hint helps Amplify environment setup
  framework = "React"
}