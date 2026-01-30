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
    "Fargate"           = "A serverless compute engine for containers that works with ECS and EKS."
    "CloudTrail"        = "A service that enables governance, compliance, and auditing of your AWS account."
    "Route Table"       = "A set of rules (routes) used to determine where network traffic is directed."
    "Internet Gateway"  = "A gateway that allows communication between your VPC and the internet."
    "NAT Gateway"       = "Allows instances in a private subnet to connect to services outside your VPC."
    "Elastic IP"        = "A static IPv4 address designed for dynamic cloud computing."
    "EBS"               = "Elastic Block Store - High-performance block storage for use with EC2."
    "EFS"               = "Elastic File System - Scalable, managed NFS file storage for AWS services."
    "Redshift"          = "A fast, fully managed data warehouse that makes it simple to analyze data."
    "Kinesis"           = "A platform for streaming data on AWS, making it easy to load and analyze video and data streams."
    "Glacier"           = "A low-cost storage service for data archiving and long-term backup."
    "SageMaker"         = "A fully managed service that provides every developer with the ability to build, train, and deploy ML models."
    "Step Functions"    = "A serverless function orchestrator that makes it easy to sequence AWS Lambda functions."
    "CloudFormation"    = "Provides a common language for you to describe and provision all the infrastructure resources."
    "CodePipeline"      = "A fully managed continuous delivery service that helps you automate your release pipelines."
  }
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "default_tags" {
  description = "Extra tags to pass to the provider"
  type        = map(string)
}
