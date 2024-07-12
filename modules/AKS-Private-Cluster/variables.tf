variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The kubernetes version for the AKS cluster."
  type        = string
}

variable "default_node_pool_name" {
  description = "The default node pool name for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the Virtual Machine."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_vnet_subnet_id" {
  description = "The virtual network Subnet ID."
  type = string
}

variable "default_node_pool_auto_scaling" {
  description = "The system default node pool auto scaling"
  type = bool
}

variable "default_node_pool_min_count" {
  description = "Minimum number of nodes in the default node pool"
  type = number
}

variable "default_node_pool_max_count" {
  description = "Maximum number of nodes in the default node pool"
  type = number
}

variable "default_node_pool_zones" {
  description = "Default node pool zones"
  type = list(string)
}

variable "identity_type" {
  description = "The identity configuration for the AKS cluster."
  type = string
  default = "SystemAssigned"
}

# variable "aks_service_principal_client_id" {
#   description = "The service principal Client ID for the AKS cluster."
#   type = string
# }

# variable "aks_service_principal_client_secret" {
#   description = "The service principal client secret for the AKS cluster."
#   type = string
# }

variable "sku_tier" {
  description = "Choose the AKS pricing tier"
  type = string
  default = "Standard"
}

variable "network_plugin" {
  description = "The network configuration either Azure (Azure CNI) or Kubelet."
  type        = string
  default     = "azure"
}
variable "network_policy" {
  description = "The network policy for the AKS cluster. Either Azure or Calico."
  type        = string
  default     = "calico"
}

variable "load_balancer_sku" {
  description = "The load balancer SKU."
  type        = string
  default = "standard"
}

variable "outbound_type" {
  description = "The outbound type either userDefinedRouting or loadbalancer."
  type = string
  default = "loadBalancer"
}

variable "dns_service_ip" {
  description = "The IP address of the DNS service"
  type = string
}

variable "service_cidr" {
  description = "The CIDR of the service"
  type = string
}

variable "private_cluster_enabled" {
  description = "Enable or disable the private cluster"
  type = bool
  default = false
}

variable "role_based_access_control_enabled" {
  description = "Enable or disable the role based access control"
  type = bool
  default = true
}


# variable "api_server_authorized_ip_ranges" {
#   description = "Authorized IP ranges to communicate with the API server."
#   type        = list(string)
#   default     = []
# }

# variable "tags" {
#   description = "A map of tags to assign to the resources."
#   type        = map(string)
#   default     = {}
# }

variable "spoke_vnet_id" {
  description = "The ID of the spoke VNet."
  type        = string
}

variable "spoke_subnet_id" {
  description = "The ID of the Spoke Subnet."
  type = string
}

variable "acr_id" {
  description = "The ID of the ACR."
  type = string
}

variable "kv_id" {
  description = "The ID of the KV."
  type = string
}

variable "node_pools" {
  description = "A map of additional node pools."
  type = map(object({
    name            = string
    vm_size         = string
    node_count      = number
    max_pods        = number
    mode            = string
    os_disk_size_gb = number
    os_type         = string

    custom_ca_trust_enabled = bool
    enable_auto_scaling     = bool
    enable_host_encryption  = bool
    enable_node_public_ip   = bool
    fips_enabled            = bool
    # kubelet_disk_type       = string
    min_count               = number
    max_count               = number
    node_labels             = map(string)
    node_taints             = list(string)
    # orchestrator_version    = string
    # os_sku                  = string
    # tags                    = map(string)
    vnet_subnet_id          = string
    zones                   = list(string)

  }))
  default = {}
}

# variable "dns_zone_name" {
#   description = "AKS DNS zone name"
#   type = string
# }

# variable "virtual_network_links" {
#   description = "List of virtual network links"
#   type        = map(object({
#     name              = string
#     virtual_network_id = string
#     registration_enabled = bool
#   }))
# }


variable "virtual_network_links" {
  description = "List of virtual network links"
  type        = map(object({
    name              = string
    virtual_network_id = string
    registration_enabled = bool
  }))
}

# variable "vnetlink_name" {
#   description = "Vnetlink name"
# }

# variable "hub_vnet_id" {
#   description = "Vnet ID of the hub"
# }
