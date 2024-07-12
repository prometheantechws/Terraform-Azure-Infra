output "subnets" {
  value = data.azurerm_subnet.aks_subnet.id
}

output "subnet_names" {
  value = module.Vnet.subnet_names["vnet1"][0]
}

output "principal_id" {
  value = module.AKS.aks_principle_id
}

output "client_id" {
  value = module.AKS.aks_client_id
}

output "object_id" {
  value = module.AKS.object_id
}