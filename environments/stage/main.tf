module "RG" {
  source              = "../../modules/RG"
  resource_group_name = var.resource_group_name
  location            = var.location
  # tags                = var.RG_tags
}

module "Vnet" {
  source              = "../../modules/Vnet"
  resource_group_name = module.RG.RG_name
  location            = var.location
  depends_on          = [module.RG]

  vnets = var.virtual_networks
}

module "vnet_peering" {
  source     = "../../modules/Vnet-peering"
  depends_on = [module.Vnet]
  peerings = {
    peering1 = {
      name                         = var.peering_name
      resource_group_name          = module.RG.RG_name
      vnet1_name                   = module.Vnet.vnet_names["vnet1"]
      vnet2_id                     = module.Vnet.vnet_ids["vnet2"]
      vnet2_name                   = module.Vnet.vnet_names["vnet2"]
      vnet1_id                     = module.Vnet.vnet_ids["vnet1"]
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
      allow_virtual_network_access = true
    }
  }
}

module "AKS" {
  source = "../../modules/AKS-Private-Cluster"

  depends_on = [
    module.RG,
    module.Vnet
  ]

  aks_cluster_name                  = var.aks_cluster_name
  resource_group_name               = module.RG.RG_name
  location                          = var.location
  dns_prefix                        = var.dns_prefix
  kubernetes_version                = var.kubernetes_version
  default_node_pool_name            = var.default_node_pool_name
  node_count                        = var.node_count
  vm_size                           = var.vm_size
  aks_vnet_subnet_id                = data.azurerm_subnet.aks_subnet.id
  default_node_pool_auto_scaling    = var.default_node_pool_auto_scaling
  default_node_pool_max_count       = var.default_node_pool_max_count
  default_node_pool_min_count       = var.default_node_pool_min_count
  default_node_pool_zones           = var.default_node_pool_zones
  identity_type                     = var.identity_type
  sku_tier                          = var.sku_tier
  network_plugin                    = var.network_plugin
  network_policy                    = var.network_policy
  load_balancer_sku                 = var.load_balancer_sku
  outbound_type                     = var.outbound_type
  dns_service_ip                    = var.dns_service_ip
  service_cidr                      = var.service_cidr
  private_cluster_enabled           = var.private_cluster_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  spoke_vnet_id                     = module.Vnet.vnet_ids["vnet2"]
  spoke_subnet_id                   = module.Vnet.subnet_ids["vnet2"]["snet-aks-stage"]
  acr_id                            = module.ACR.acr_id
  kv_id                             = module.key_vault.kv_id

  ############################# HUB VNET LINK #############################

  virtual_network_links = {
    link1 = {
      name                 = "vnetl-hub"
      virtual_network_id   = module.Vnet.vnet_ids["vnet1"]
      registration_enabled = false
    }
  }

  #############################Private DNS ZONE#############################

  node_pools = {
    userpool-1 = {
      name                    = "npuserpool"
      vm_size                 = "Standard_E2as_v5"
      node_count              = 1
      max_pods                = 30
      mode                    = "User"
      os_disk_size_gb         = 100
      os_type                 = "Linux"
      custom_ca_trust_enabled = false
      enable_auto_scaling     = true
      enable_host_encryption  = false
      enable_node_public_ip   = false
      fips_enabled            = false
      min_count               = 1
      max_count               = 3
      node_labels             = {}
      node_taints             = []
      vnet_subnet_id          = data.azurerm_subnet.aks_subnet.id
      zones                   = ["1", "2", "3"]
    }
  }

}

module "ACR" {
  source = "../../modules/Azure-Container-Registries"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  acr_name            = var.acr_name
  resource_group_name = module.RG.RG_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
}

module "acr_private_endpoints" {
  source = "../../modules/Azure-Private-Endpoints"
  depends_on = [
    module.RG,
    module.Vnet,
    module.ACR
  ]

  resource_group_name   = module.RG.RG_name
  location              = var.location
  vnet_name             = module.Vnet.vnet_names["vnet1"]
  subnet_name           = module.Vnet.subnet_names["vnet1"][1]
  private_endpoint_name = var.acr_private_endpoint_name
  private_service_connections = {
    acr = {
      name                           = "acr-link"
      private_connection_resource_id = module.ACR.acr_id
      subresource_names              = ["registry"]
      is_manual_connection           = false
    }
  }
  private_dns_zone_group_name = "private-dns-zone-group"
  private_dns_zone_ids        = [module.acr_private_dns_zone.dns_zone_id]
}

module "acr_private_dns_zone" {
  source = "../../modules/Private-DNS-Zone"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  dns_zone_name       = var.acr_dns_zone_name
  resource_group_name = module.RG.RG_name
  virtual_network_links = {
    link1 = {
      name                 = "pl-hub-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet1"]
      registration_enabled = false
    }
    link2 = {
      name                 = "pl-spoke-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet2"]
      registration_enabled = false
    }
  }
}

module "linux_vm" {
  source = "../../modules/Linux-Virtual-Machines"
  depends_on = [
    module.RG,
    module.Vnet
  ]
  create_public_ip    = false
  resource_group_name = module.RG.RG_name
  location            = var.location
  vnet_name           = module.Vnet.vnet_names["vnet1"]
  subnet_name         = module.Vnet.subnet_names["vnet1"][0]
  vm_size             = var.linux_vm_size
  vm_admin_username   = var.linux_vm_admin_username
  vm_admin_password   = var.linux_vm_admin_password
  vm_name             = var.linux_vm_name
  vm_type             = var.linux_vm_type # or "Windows"
  subnet_id           = module.Vnet.subnet_ids["vnet1"]["snet-shared-stage"]
}

module "linux_agent_vm" {
  source = "../../modules/Linux-Virtual-Machines"
  depends_on = [
    module.RG,
    module.Vnet
  ]
  create_public_ip    = true
  resource_group_name = module.RG.RG_name
  location            = var.location
  vnet_name           = module.Vnet.vnet_names["vnet1"]
  subnet_name         = module.Vnet.subnet_names["vnet1"][0]
  vm_size             = var.linux_jumpbox_vm_size
  vm_admin_username   = var.linux_vm_jumpbox_admin_username
  vm_admin_password   = var.linux_vm_jumpbox_admin_password
  vm_name             = var.linux_vm_jumpbox_name
  vm_type             = var.linux_vm_jumpbox_type # or "Windows"
  subnet_id           = module.Vnet.subnet_ids["vnet1"]["snet-shared-stage"]
}

module "windows_vm" {
  source              = "../../modules/Windows-Virtual-Machines"
  resource_group_name = module.RG.RG_name
  location            = var.location
  vnet_name           = module.Vnet.vnet_names["vnet1"]
  subnet_name         = module.Vnet.subnet_names["vnet1"][0]
  vm_size             = var.windows_vm_size
  vm_admin_username   = var.windows_vm_admin_username
  vm_admin_password   = var.windows_vm_admin_password
  vm_name             = var.windows_vm_name
  vm_type             = var.windows_vm_type # or "Windows"
  subnet_id           = module.Vnet.subnet_ids["vnet1"]["snet-shared-stage"]
}

module "storage_account" {
  source = "../../modules/Storage-Accounts"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  resource_group_name           = module.RG.RG_name
  location                      = var.location
  storage_account_name          = var.storage_account_name
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
}

module "storage_account_private_endpoints" {
  source = "../../modules/Azure-Private-Endpoints"
  depends_on = [
    module.RG,
    module.Vnet,
    module.storage_account
  ]

  resource_group_name   = module.RG.RG_name
  location              = var.location
  vnet_name             = module.Vnet.vnet_names["vnet1"]
  subnet_name           = module.Vnet.subnet_names["vnet1"][1]
  private_endpoint_name = var.storage_blob_private_endpoint_name
  private_service_connections = {
    storage_account = {
      name                           = "storage-link"
      private_connection_resource_id = module.storage_account.storage_account_id
      subresource_names              = ["blob"]
      is_manual_connection           = false
    }
  }
  private_dns_zone_group_name = "private-dns-zone-group"
  private_dns_zone_ids        = [module.storage_account_private_dns_zone.dns_zone_id]
}


module "storage_account_private_dns_zone" {
  source = "../../modules/Private-DNS-Zone"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  dns_zone_name       = var.storage_blob_dns_zone_name
  resource_group_name = module.RG.RG_name
  virtual_network_links = {
    link1 = {
      name                 = "pl-hub-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet1"]
      registration_enabled = false
    }
    link2 = {
      name                 = "pl-spoke-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet2"]
      registration_enabled = false
    }
  }
}

module "storage_account_file_private_endpoints" {
  source = "../../modules/Azure-Private-Endpoints"
  depends_on = [
    module.RG,
    module.Vnet,
    module.storage_account
  ]

  resource_group_name   = module.RG.RG_name
  location              = var.location
  vnet_name             = module.Vnet.vnet_names["vnet1"]
  subnet_name           = module.Vnet.subnet_names["vnet1"][1]
  private_endpoint_name = var.storage_file_private_endpoint_name
  private_service_connections = {
    storage_account = {
      name                           = "storage-fileshare-link"
      private_connection_resource_id = module.storage_account.storage_account_id
      subresource_names              = ["file"]
      is_manual_connection           = false
    }
  }
  private_dns_zone_group_name = "private-dns-zone-group"
  private_dns_zone_ids        = [module.storage_account_file_private_dns_zone.dns_zone_id]
}


module "storage_account_file_private_dns_zone" {
  source = "../../modules/Private-DNS-Zone"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  dns_zone_name       = var.storage_file_dns_zone_name
  resource_group_name = module.RG.RG_name
  virtual_network_links = {
    link1 = {
      name                 = "pl-hub-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet1"]
      registration_enabled = false
    }
    link2 = {
      name                 = "pl-spoke-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet2"]
      registration_enabled = false
    }
  }
}

module "key_vault" {
  source = "../../modules/Key-Vaults"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  resource_group_name        = module.RG.RG_name
  location                   = var.location
  key_vault_name             = var.key_vault_name
  sku_name                   = var.key_vault_location
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_purge_protection_enabled

  # KV_ACCESS_POLICY  

  key_vault_dependency    = [module.AKS]
  key_vault_id            = module.key_vault.kv_id
  tenant_id               = module.key_vault.kv_tenanet_id
  object_id               = module.AKS.aks_client_id
  key_permissions         = ["Get"]
  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]

}

module "kv_private_endpoints" {
  source = "../../modules/Azure-Private-Endpoints"
  depends_on = [
    module.RG,
    module.Vnet,
    module.key_vault
  ]

  resource_group_name   = module.RG.RG_name
  location              = var.location
  vnet_name             = module.Vnet.vnet_names["vnet1"]
  subnet_name           = module.Vnet.subnet_names["vnet1"][1]
  private_endpoint_name = var.kv_private_endpoint_name
  private_service_connections = {
    kv = {
      name                           = "kv-link"
      private_connection_resource_id = module.key_vault.kv_id
      subresource_names              = ["vault"]
      is_manual_connection           = false
    }
  }
  private_dns_zone_group_name = "private-dns-zone-group"
  private_dns_zone_ids        = [module.kv_private_dns_zone.dns_zone_id]
}

module "kv_private_dns_zone" {
  source = "../../modules/Private-DNS-Zone"
  depends_on = [
    module.RG,
    module.Vnet
  ]

  dns_zone_name       = var.kv_dns_zone_name
  resource_group_name = module.RG.RG_name
  virtual_network_links = {
    link1 = {
      name                 = "pl-hub-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet1"]
      registration_enabled = false
    }
    link2 = {
      name                 = "pl-spoke-vnet-link"
      virtual_network_id   = module.Vnet.vnet_ids["vnet2"]
      registration_enabled = false
    }
  }
}
