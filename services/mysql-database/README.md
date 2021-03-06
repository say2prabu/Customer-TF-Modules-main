# terraform-azurerm-azuredbformysql
Terraform service module to for an Azure MySQL Database.
## Description
Azure Database for MySQL is a relational database service in the Microsoft cloud based on the MySQL Community Edition (available under the GPLv2 license) database engine, versions 5.7, and 8.0.

Azure Database for MySQL Single Server is a fully managed database service designed for minimal customization. The single server platform is designed to handle most of the database management functions such as patching, backups, high availability, security with minimal user configuration and control.
## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurerdbforysql"></a> [azurerdbforysql](#module\_azurerdbforysql) | ../../modules/terraform-azurerm-azuredbformysql | n/a |
| <a name="module_naming"></a> [naming](#module\_naming) | ../../modules/terraform-naming | n/a |

## Module Example Use
```hcl
module "azuredbformysql" {
  name                             = "global unique name"
  version                          = "8.0"
  sku_name                         = "GP_Gen5_2"
  storage_mb                       = "5120"
  administrator_login              = "sqladministrator"
  administrator_login_password     = "koLNPhjsCQs87J?"
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  tags                             = {
      "AtosManaged" = "true"
  }
}
module "naming"  {
  azure_region      = westeurope
  organization-code = sie
  environment-code  = t
  subscription-code = lan1
}

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention. | `string` | n/a | yes |
| <a name="input_charset"></a> [charset](#input\_charset) | n/a | `string` | `"utf8"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | n/a | `string` | n/a | yes |
| <a name="input_environment-code"></a> [environment-code](#input\_environment-code) | A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc. | `string` | n/a | yes |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier. | `bool` | n/a | yes |
| <a name="input_mysql_server_location"></a> [mysql\_server\_location](#input\_mysql\_server\_location) | n/a | `string` | n/a | yes |
| <a name="input_mysql_server_resource_group_name"></a> [mysql\_server\_resource\_group\_name](#input\_mysql\_server\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_mysql_server_sku_name"></a> [mysql\_server\_sku\_name](#input\_mysql\_server\_sku\_name) | n/a | `string` | `"GP_Gen5_2"` | no |
| <a name="input_mysql_server_storage_mb"></a> [mysql\_server\_storage\_mb](#input\_mysql\_server\_storage\_mb) | n/a | `number` | `5120` | no |
| <a name="input_mysql_server_version"></a> [mysql\_server\_version](#input\_mysql\_server\_version) | n/a | `string` | `"8.0"` | no |
| <a name="input_mysql_tags"></a> [mysql\_tags](#input\_mysql\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "Atosmanaged": "True"<br>}</pre> | no |
| <a name="input_organization-code"></a> [organization-code](#input\_organization-code) | A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats | `string` | n/a | yes |
| <a name="input_subscription-code"></a> [subscription-code](#input\_subscription-code) | A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | output "id"{ value = module.azurerdbforysql.server\_id } |

## License
Atos, all rights protected - 2021.