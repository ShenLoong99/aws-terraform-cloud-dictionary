variable "github_token" {
  description = "GitHub token for Amplify to access the repository"
  type        = string
  sensitive   = true
}

variable "github_repo" {
  description = "The URL of your frontend React repository"
  type        = string
  default     = "https://github.com/ShenLoong99/aws-terraform-cloud-dictionary"
}

variable "api_invoke_url" {
  description = "The invoke URL of the API Gateway stage"
  type        = string
}
