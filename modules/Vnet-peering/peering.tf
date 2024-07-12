resource "azurerm_virtual_network_peering" "Vnet_peering" {
  for_each = var.peerings

  name                       = "${each.key}-to-${each.value.vnet2_name}"
  resource_group_name        = each.value.resource_group_name
  virtual_network_name       = each.value.vnet1_name
  remote_virtual_network_id  = each.value.vnet2_id
  allow_forwarded_traffic    = each.value.allow_forwarded_traffic
  allow_gateway_transit      = each.value.allow_gateway_transit
  use_remote_gateways        = each.value.use_remote_gateways
  allow_virtual_network_access = each.value.allow_virtual_network_access
}

resource "azurerm_virtual_network_peering" "peering_reverse" {
  for_each = var.peerings

  name                       = "${each.key}-to-${each.value.vnet1_name}"
  resource_group_name        = each.value.resource_group_name
  virtual_network_name       = each.value.vnet2_name
  remote_virtual_network_id  = each.value.vnet1_id
  allow_forwarded_traffic    = each.value.allow_forwarded_traffic
  allow_gateway_transit      = each.value.allow_gateway_transit
  use_remote_gateways        = each.value.use_remote_gateways
  allow_virtual_network_access = each.value.allow_virtual_network_access
}