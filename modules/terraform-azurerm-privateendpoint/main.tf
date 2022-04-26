resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresources_name
  }
}