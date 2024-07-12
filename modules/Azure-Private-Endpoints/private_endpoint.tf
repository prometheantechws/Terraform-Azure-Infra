resource "azurerm_private_endpoint" "example" {
  for_each            = var.private_service_connections
  name                = "${var.private_endpoint_name}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = each.value.name
    private_connection_resource_id = each.value.private_connection_resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = each.value.is_manual_connection
  }

  private_dns_zone_group {
    name = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}