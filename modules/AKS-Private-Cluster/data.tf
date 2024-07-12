data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.resource_group_name
  depends_on = [ azurerm_kubernetes_cluster.aks ]
}

data "azurerm_private_dns_zone" "all_zones" {
  name = local.aks_private_dns_zone
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
}
 