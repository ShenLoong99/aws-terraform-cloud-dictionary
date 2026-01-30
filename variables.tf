variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "github_token" {
  description = "GitHub token for Amplify to access the repository"
  type        = string
  sensitive   = true
}
