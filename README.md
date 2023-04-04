## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_elasticpool.mssql_elastic_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_elasticpool) | resource |
| [azurerm_mssql_server.mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_server_to_elastic_pool"></a> [add\_server\_to\_elastic\_pool](#input\_add\_server\_to\_elastic\_pool) | Whether an elastic pool should be made, defaults to false | `bool` | `false` | no |
| <a name="input_elastic_pool_license_type"></a> [elastic\_pool\_license\_type](#input\_elastic\_pool\_license\_type) | The license type of a elastic pool if one is provisioned | `string` | `null` | no |
| <a name="input_elastic_pool_maintenance_configuration_name"></a> [elastic\_pool\_maintenance\_configuration\_name](#input\_elastic\_pool\_maintenance\_configuration\_name) | The maintaence mode of the elastic pool, if one is provisoned | `string` | `null` | no |
| <a name="input_elastic_pool_max_size_gb"></a> [elastic\_pool\_max\_size\_gb](#input\_elastic\_pool\_max\_size\_gb) | The max size in GB for the elastic pool, if one is provisioned | `string` | `null` | no |
| <a name="input_elastic_pool_settings"></a> [elastic\_pool\_settings](#input\_elastic\_pool\_settings) | The settings block for Elastic Pool | `map(any)` | `{}` | no |
| <a name="input_elastic_pool_zone_redundant"></a> [elastic\_pool\_zone\_redundant](#input\_elastic\_pool\_zone\_redundant) | Whether or not the elastic pool is zone redundant or not, requires Premium or BusinessCritical | `bool` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for this resource to be put in | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version of the SQL server, defaults to 1.2 | `string` | `"1.2"` | no |
| <a name="input_outbound_network_restriction_enabled"></a> [outbound\_network\_restriction\_enabled](#input\_outbound\_network\_restriction\_enabled) | Whether outbound network access is restricted, defaults to false | `bool` | `false` | no |
| <a name="input_primary_user_assigned_identity_id"></a> [primary\_user\_assigned\_identity\_id](#input\_primary\_user\_assigned\_identity\_id) | The ID of User-Assigned managed identity if one is set, defaults to null | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled on the server, default is false | `bool` | `false` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists | `string` | n/a | yes |
| <a name="input_sql_admin_password"></a> [sql\_admin\_password](#input\_sql\_admin\_password) | The password of the local server admin | `string` | n/a | yes |
| <a name="input_sql_admin_username"></a> [sql\_admin\_username](#input\_sql\_admin\_username) | The username of the local server admin user | `string` | n/a | yes |
| <a name="input_sql_server_elastic_pool_name"></a> [sql\_server\_elastic\_pool\_name](#input\_sql\_server\_elastic\_pool\_name) | The name of the SQL server pull if one is made | `string` | `null` | no |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | The name of the SQL server | `string` | n/a | yes |
| <a name="input_sql_server_settings"></a> [sql\_server\_settings](#input\_sql\_server\_settings) | The settings block for MSSQL server | `map(any)` | `{}` | no |
| <a name="input_sql_server_version"></a> [sql\_server\_version](#input\_sql\_server\_version) | The version of SQL Server to run, default is 12.0 | `string` | `"12.0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_pool_id"></a> [elastic\_pool\_id](#output\_elastic\_pool\_id) | The ID of the elastic pool, if one is provisoned |
| <a name="output_sql_server_admin_password"></a> [sql\_server\_admin\_password](#output\_sql\_server\_admin\_password) | The password of the SQL server |
| <a name="output_sql_server_admin_username"></a> [sql\_server\_admin\_username](#output\_sql\_server\_admin\_username) | The username of the SQL server |
| <a name="output_sql_server_fqdn"></a> [sql\_server\_fqdn](#output\_sql\_server\_fqdn) | The FQDN of the sql server |
| <a name="output_sql_server_id"></a> [sql\_server\_id](#output\_sql\_server\_id) | The ID of the SQL Server |
| <a name="output_sql_server_identity"></a> [sql\_server\_identity](#output\_sql\_server\_identity) | The identity block of the SQL Server |
| <a name="output_sql_server_name"></a> [sql\_server\_name](#output\_sql\_server\_name) | The name of the SQL Server |
