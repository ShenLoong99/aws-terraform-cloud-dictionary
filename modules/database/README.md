<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dictionary_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table_item.dictionary_items](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in | `string` | n/a | yes |
| <a name="input_cloud_terms"></a> [cloud\_terms](#input\_cloud\_terms) | Define the list of cloud terms and definitions | `map(string)` | <pre>{<br/>  "API Gateway": "Fully managed service to create, publish, and secure APIs at scale.",<br/>  "Auto Scaling": "Automatically adjusts capacity to maintain steady performance.",<br/>  "CloudFormation": "Provides a common language for you to describe and provision all the infrastructure resources.",<br/>  "CloudFront": "A fast content delivery network (CDN) service.",<br/>  "CloudTrail": "A service that enables governance, compliance, and auditing of your AWS account.",<br/>  "CloudWatch": "Monitoring and observability service for AWS resources.",<br/>  "CodePipeline": "A fully managed continuous delivery service that helps you automate your release pipelines.",<br/>  "DynamoDB": "A fast, flexible NoSQL database service for single-digit millisecond latency.",<br/>  "EBS": "Elastic Block Store - High-performance block storage for use with EC2.",<br/>  "EC2": "Elastic Compute Cloud - Virtual servers for running applications.",<br/>  "EFS": "Elastic File System - Scalable, managed NFS file storage for AWS services.",<br/>  "Elastic Beanstalk": "Service for deploying and scaling web applications and services.",<br/>  "Elastic IP": "A static IPv4 address designed for dynamic cloud computing.",<br/>  "Fargate": "A serverless compute engine for containers that works with ECS and EKS.",<br/>  "Glacier": "A low-cost storage service for data archiving and long-term backup.",<br/>  "IAM": "Identity and Access Management - Securely manage access to AWS services.",<br/>  "Internet Gateway": "A gateway that allows communication between your VPC and the internet.",<br/>  "Kinesis": "A platform for streaming data on AWS, making it easy to load and analyze video and data streams.",<br/>  "Lambda": "Serverless compute service that runs code in response to events.",<br/>  "NAT Gateway": "Allows instances in a private subnet to connect to services outside your VPC.",<br/>  "RDS": "Relational Database Service - Managed relational databases like MySQL/PostgreSQL.",<br/>  "Redshift": "A fast, fully managed data warehouse that makes it simple to analyze data.",<br/>  "Route 53": "A scalable Domain Name System (DNS) web service.",<br/>  "Route Table": "A set of rules (routes) used to determine where network traffic is directed.",<br/>  "S3": "Simple Storage Service - Scalable object storage in the cloud.",<br/>  "SNS": "Simple Notification Service - Pub/sub messaging for microservices.",<br/>  "SQS": "Simple Queue Service - Fully managed message queuing service.",<br/>  "SageMaker": "A fully managed service that provides every developer with the ability to build, train, and deploy ML models.",<br/>  "Step Functions": "A serverless function orchestrator that makes it easy to sequence AWS Lambda functions.",<br/>  "VPC": "Virtual Private Cloud - A private, isolated section of the AWS cloud."<br/>}</pre> | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Extra tags to pass to the provider | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | ARN of the DynamoDB dictionary table |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | Name of the DynamoDB dictionary table |
<!-- END_TF_DOCS -->