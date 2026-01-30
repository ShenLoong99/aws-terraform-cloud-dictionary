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

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  description = "Extra tags to pass to the provider"
  type        = map(string)
}

variable "api_invoke_url" {
  description = "The invoke URL of the API Gateway stage"
  type        = string
}
