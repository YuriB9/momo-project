<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.6 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.85.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.85.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_instance.this](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/resources/compute_instance) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [yandex_iam_service_account.sa-static-key](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/data-sources/iam_service_account) | data source |
| [yandex_vpc_security_group.sg-dev-instance](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/data-sources/vpc_security_group) | data source |
| [yandex_vpc_security_group.sg-internet](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/data-sources/vpc_security_group) | data source |
| [yandex_vpc_subnet.subnet-dev](https://registry.terraform.io/providers/yandex-cloud/yandex/0.85.0/docs/data-sources/vpc_subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | static access key | `string` | n/a | yes |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | cloud id where to create the sources | `string` | n/a | yes |
| <a name="input_core_fraction"></a> [core\_fraction](#input\_core\_fraction) | Baseline performance for a core as a percent | `number` | `5` | no |
| <a name="input_cores"></a> [cores](#input\_cores) | CPU cores for the instance | `number` | `2` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | folder id where to create the sources | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Host name for the instance | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Yandex Cloud Compute Image ID | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory size for the instance in GB | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Yandex Cloud Compute instance name | `string` | n/a | yes |
| <a name="input_network_zones"></a> [network\_zones](#input\_network\_zones) | Yandex Cloud network zones | `set(string)` | <pre>[<br>  "ru-central1-a",<br>  "ru-central1-b",<br>  "ru-central1-c"<br>]</pre> | no |
| <a name="input_platform_id"></a> [platform\_id](#input\_platform\_id) | The type of virtual machine to create | `string` | `"standard-v1"` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Specifies if the instance is preemptible | `bool` | `true` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | secret for static access key | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of the boot disk in GB | `string` | `"40"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Path to public\_key for SSH login | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | token to access yandex cloud | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | User to login | `string` | `"ansible"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Yandex Cloud compute default zone | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm"></a> [external\_ip\_address\_vm](#output\_external\_ip\_address\_vm) | n/a |
| <a name="output_internal_ip_address_vm"></a> [internal\_ip\_address\_vm](#output\_internal\_ip\_address\_vm) | n/a |
<!-- END_TF_DOCS -->