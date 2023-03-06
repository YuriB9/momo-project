<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.85.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.85.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_resourcemanager_folder_iam_member.sa-editor](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/resources/resourcemanager_folder_iam_member) | resource |
| [yandex_storage_bucket.s3-tfstate](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/resources/storage_bucket) | resource |
| [yandex_iam_service_account.sa](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/data-sources/iam_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | static access key | `string` | n/a | yes |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | cloud id where to create the sources | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | folder id where to create the sources | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | secret for static access key | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | token to access yandex cloud | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->