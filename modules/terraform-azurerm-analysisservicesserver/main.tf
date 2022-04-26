resource "azurerm_analysis_services_server" "analysis_services_server" {
  admin_users               = var.admin_users
  backup_blob_container_uri = var.backup_blob_container_uri
  enable_power_bi_service   = var.enable_power_bi_service
  location                  = var.location
  name                      = var.name
  querypool_connection_mode = var.querypool_connection_mode
  resource_group_name       = var.resource_group_name
  sku                       = var.sku
  tags                      = var.tags

  dynamic "ipv4_firewall_rule" {
    for_each = var.ipv4_firewall_rule
    content {
      name        = ipv4_firewall_rule.value["name"]
      range_end   = ipv4_firewall_rule.value["range_end"]
      range_start = ipv4_firewall_rule.value["range_start"]
    }
  }
}