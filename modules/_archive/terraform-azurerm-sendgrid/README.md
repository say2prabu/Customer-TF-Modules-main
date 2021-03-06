## terraform-azurerm-sendgrid
Terraform module to create a Azure Sendgrid account

## Description
*SendGrid is a cloud-based SMTP provider that allows you to send email without having to maintain email servers. Azure hosted Sendgrid is a SaaS platform provided by Sendgrid.
*There is no native way of deploying Azure hosted Sendgrid through Terraform. So we are embeding an ARM template in terraform module.
*Once sendgrid has been deployed click on configure now that will setup an account in sendgrid portal. In Sendgrid protal you can create api keys.
*There isn't much help available but please refer the documentation here for further help https://docs.sendgrid.com/for-developers/partners/microsoft-azure-2021
Please not if delete a sendgrid account and trying to redeploy you might have wait upto 24 hours before you can redeploy even if it is different name.
## Module example use
```hcl
*module "send_grid" {
 source              = "../../modules/terraform-azurerm-sendgrid"
 sendgrid_name       = var.sendgrid_name
 resource_group_name = resource.azurerm_resource_group.main.name
 deployment_mode     = var.arm_deployment_mode
 sendgrid_properties = var.sendgrid_properties
 azureSubscriptionId = var.azureSubscriptionId
 tags                = var.tags
*}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group_template_deployment.sendgrid](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azureSubscriptionId"></a> [azureSubscriptionId](#input\_azureSubscriptionId) | n/a | `string` | n/a | yes |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | n/a | `string` | `"Incremental"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sendgrid_name"></a> [sendgrid\_name](#input\_sendgrid\_name) | n/a | `string` | n/a | yes |
| <a name="input_sendgrid_properties"></a> [sendgrid\_properties](#input\_sendgrid\_properties) | n/a | <pre>object({<br>    quantity  = number<br>    autoRenew = bool<br>    planId    = string<br>    offerId   = string<br>    termId    = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

No outputs.
