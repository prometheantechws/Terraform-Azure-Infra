resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_vnet_subnet_id
    enable_auto_scaling = var.default_node_pool_auto_scaling
    min_count               = var.default_node_pool_min_count
    max_count               = var.default_node_pool_max_count
    zones = var.default_node_pool_zones

    upgrade_settings {
      drain_timeout_in_minutes = 0
      max_surge = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = var.identity_type
  }

  sku_tier = var.sku_tier

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    outbound_type     = var.outbound_type
    dns_service_ip    = var.dns_service_ip
    service_cidr      = var.service_cidr
  }

  # Install csi driver.
  key_vault_secrets_provider {
    secret_rotation_enabled = false
  }

  private_cluster_enabled = var.private_cluster_enabled

  role_based_access_control_enabled = var.role_based_access_control_enabled

  # tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_nodes" {
  for_each = var.node_pools
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.name
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  max_pods              = each.value.max_pods
  mode                  = each.value.mode
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_type               = each.value.os_type

  custom_ca_trust_enabled = each.value.custom_ca_trust_enabled
  enable_auto_scaling     = each.value.enable_auto_scaling
  enable_host_encryption  = each.value.enable_host_encryption
  enable_node_public_ip   = each.value.enable_node_public_ip
  fips_enabled            = each.value.fips_enabled
  # kubelet_disk_type       = each.value.kubelet_disk_type
  min_count               = each.value.min_count
  max_count               = each.value.max_count
  node_labels             = each.value.node_labels
  node_taints             = each.value.node_taints
  # tags                    = each.value.tags
  vnet_subnet_id          = each.value.vnet_subnet_id
  zones                   = each.value.zones

  # upgrade_settings {
  #   drain_timeout_in_minutes = 0
  #   max_surge = "10%"
  #   node_soak_duration_in_minutes = 0
  # }
}
