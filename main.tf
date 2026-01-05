provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "CloudDictionary"
      Environment = "Prod"
      ManagedBy   = "Terraform"
    }
  }
}