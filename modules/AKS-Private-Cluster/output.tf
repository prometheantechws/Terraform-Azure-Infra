output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_client_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

################################
output "aks_principle_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}