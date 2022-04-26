provider "azurerm" {
  features {}
}

module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}

module "resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.naming.resource_group.name
  location = module.naming.azure_region
  tags     = var.rsg_tags
}

# Flexible server deployment
module "postgresql" {
  source = "../../modules/terraform-azurerm-postgresql"

  deployment_mode_flexible = true
  name                     = module.naming.postgresql_server.name_unique
  resource_group_name      = module.resourcegroup.resource_group_name
  location                 = module.resourcegroup.resource_group_location
  storage_mb               = var.storage_mb
  sku_name                 = var.sku_name

  tags = var.postgresql_server_tags

  postgresql_databases = var.postgresql_databases
}

# Single server deployment
#module "postgresql" {
#  source = "../../modules/terraform-azurerm-postgresql"
#
#  deployment_mode_flexible     = var.deployment_mode_flexible
#  name                         = module.naming.postgresql_server.name_unique
#  resource_group_name          = module.resourcegroup.resource_group_name
#  location                     = module.resourcegroup.resource_group_location
#  storage_mb                   = var.storage_mb
#  auto_grow_enabled            = var.auto_grow_enabled
#  sku_name                     = var.sku_name
#
#  tags = var.postgresql_server_tags
#
#  postgresql_databases = var.postgresql_databases
#}