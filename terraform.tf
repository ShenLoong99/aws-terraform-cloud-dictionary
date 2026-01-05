terraform {

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "my-terraform-aws-projects-2025"
    workspaces {
      name = "aws-terraform-cloud-dictionary"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}