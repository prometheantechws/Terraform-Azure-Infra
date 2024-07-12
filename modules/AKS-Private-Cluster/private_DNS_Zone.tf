locals {
  aks_private_dns_zone = join(".", slice(split(".", azurerm_kubernetes_cluster.aks.private_fqdn), 1, 6))
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each             = var.virtual_network_links
  name                 = each.value.name
  resource_group_name  = data.azurerm_kubernetes_cluster.aks_cluster.node_resource_group
  private_dns_zone_name = local.aks_private_dns_zone
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  depends_on = [ azurerm_kubernetes_cluster.aks ]
}