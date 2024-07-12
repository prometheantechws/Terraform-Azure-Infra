output "vnet_ids" {
  description = "IDs of the created VNETs"
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value = {
    for k, v in azurerm_virtual_network.vnet :
    k => { for subnet in v.subnet : subnet.name => subnet.id }
  }
}

output "vnet_names" {
  description = "Names of the created VNETs"
  value = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}

output "subnet_names" {
  description = "Names of the created subnets"
  value = {
    for k, v in azurerm_virtual_network.vnet : k => [for subnet in v.subnet : subnet.name]
  }
}