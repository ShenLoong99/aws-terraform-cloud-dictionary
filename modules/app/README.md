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
| [aws_amplify_app.dictionary_frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_webhook.build_webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_webhook) | resource |
| [null_resource.curl_webhook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_invoke_url"></a> [api\_invoke\_url](#input\_api\_invoke\_url) | The invoke URL of the API Gateway stage | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Extra tags to pass to the provider | `map(string)` | n/a | yes |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | The URL of your frontend React repository | `string` | `"https://github.com/ShenLoong99/aws-terraform-cloud-dictionary"` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token for Amplify to access the repository | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amplify_app_id"></a> [amplify\_app\_id](#output\_amplify\_app\_id) | ID of the Amplify App |
| <a name="output_amplify_app_url"></a> [amplify\_app\_url](#output\_amplify\_app\_url) | The URL of the hosted React application |
| <a name="output_amplify_branch_name"></a> [amplify\_branch\_name](#output\_amplify\_branch\_name) | ID of the Amplify App |
<!-- END_TF_DOCS -->