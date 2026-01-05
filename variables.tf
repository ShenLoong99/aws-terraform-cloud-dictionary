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

variable "github_repo" {
  description = "The URL of your frontend React repository"
  type        = string
  default     = "https://github.com/ShenLoong99/aws-terraform-cloud-dictionary"
}

# Define the list of cloud terms and definitions
variable "cloud_terms" {
  type = map(string)
  default = {
    "S3"                = "Simple Storage Service - Scalable object storage in the cloud."
    "EC2"               = "Elastic Compute Cloud - Virtual servers for running applications."
    "Lambda"            = "Serverless compute service that runs code in response to events."
    "DynamoDB"          = "A fast, flexible NoSQL database service for single-digit millisecond latency."
    "IAM"               = "Identity and Access Management - Securely manage access to AWS services."
    "VPC"               = "Virtual Private Cloud - A private, isolated section of the AWS cloud."
    "Route 53"          = "A scalable Domain Name System (DNS) web service."
    "CloudFront"        = "A fast content delivery network (CDN) service."
    "CloudWatch"        = "Monitoring and observability service for AWS resources."
    "SNS"               = "Simple Notification Service - Pub/sub messaging for microservices."
    "SQS"               = "Simple Queue Service - Fully managed message queuing service."
    "RDS"               = "Relational Database Service - Managed relational databases like MySQL/PostgreSQL."
    "Elastic Beanstalk" = "Service for deploying and scaling web applications and services."
    "API Gateway"       = "Fully managed service to create, publish, and secure APIs at scale."
    "Auto Scaling"      = "Automatically adjusts capacity to maintain steady performance."
  }
}