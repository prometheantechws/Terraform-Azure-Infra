output "peering_ids" {
  description = "IDs of the created VNET peerings"
  value = { for k, v in azurerm_virtual_network_peering.Vnet_peering : k => v.id }
}