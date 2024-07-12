# RG Module
variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Name of the location"
}

# Vnet Module
variable "virtual_networks" {}

# Used in Vnet-Peering Module.
variable "peering_name" {
  description = "Name of the Vnet-Peering"
}

# AKS module.

variable "aks_cluster_name" {}
variable "dns_prefix" {}
variable "kubernetes_version" {}
variable "default_node_pool_name" {}
variable "node_count" {}
variable "vm_size" {}
variable "default_node_pool_auto_scaling" {}
variable "default_node_pool_max_count" {}
variable "default_node_pool_min_count" {}
variable "default_node_pool_zones" {}
variable "identity_type" {}
variable "sku_tier" {}
variable "network_plugin" {}
variable "network_policy" {}
variable "load_balancer_sku" {}
variable "outbound_type" {}
variable "dns_service_ip" {}
variable "service_cidr" {}
variable "private_cluster_enabled" {}
variable "role_based_access_control_enabled" {}

# ACR module.

variable "acr_name" {}
variable "sku" {}
variable "admin_enabled" {}
variable "acr_private_endpoint_name" {}
variable "acr_dns_zone_name" {}

# Linux VM

variable "linux_vm_size" {}

variable "linux_vm_admin_username" {
  sensitive = true
}

variable "linux_vm_admin_password" {
  sensitive = true
}

variable "linux_vm_name" {}
variable "linux_vm_type" {}

# Linux JumpBox VM

variable "linux_jumpbox_vm_size" {}

variable "linux_vm_jumpbox_admin_username" {
  sensitive = true
}

variable "linux_vm_jumpbox_admin_password" {
  sensitive = true
}

variable "linux_vm_jumpbox_name" {}

variable "linux_vm_jumpbox_type" {}


# Windows VM

variable "windows_vm_size" {}

variable "windows_vm_admin_username" {
  sensitive = true
}

variable "windows_vm_admin_password" {
  sensitive = true
}

variable "windows_vm_name" {}
variable "windows_vm_type" {}

# Storage Account

variable "storage_account_name" {}
variable "account_tier" {}
variable "account_replication_type" {}
variable "public_network_access_enabled" {}

variable "storage_blob_private_endpoint_name" {}
variable "storage_blob_dns_zone_name" {}
variable "storage_file_private_endpoint_name" {}
variable "storage_file_dns_zone_name" {}

# Key Vault

variable "key_vault_name" {}
variable "key_vault_location" {}
variable "key_vault_soft_delete_retention_days" {}
variable "key_vault_purge_protection_enabled" {}

variable "kv_private_endpoint_name" {}
variable "kv_dns_zone_name" {}