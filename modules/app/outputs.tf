output "amplify_app_url" {
  description = "The URL of the hosted React application"
  # This combines the branch name and the default generated domain
  value = "https://${aws_amplify_branch.main.branch_name}.${aws_amplify_app.dictionary_frontend.default_domain}"
}

output "amplify_app_id" {
  description = "ID of the Amplify App"
  value       = aws_amplify_app.dictionary_frontend.id
}

output "amplify_branch_name" {
  description = "ID of the Amplify App"
  value       = aws_amplify_branch.main.branch_name
}
