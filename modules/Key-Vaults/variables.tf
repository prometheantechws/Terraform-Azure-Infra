variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The Azure Region"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the vault"
  type        = string
}

variable "sku_name" {
  description = "The name of the sku"
  type = string
}

variable "soft_delete_retention_days" {
  description = "value"
  type = number
}

variable "purge_protection_enabled" {
  description = "value"
  type = bool
  default = true
}

# KV_ACCESS_POLICY

variable "key_vault_dependency" {
  description = "Dependency for the Key Vault resource"
  type        = list(any)
}

variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID for the principal"
  type        = string
}

variable "key_permissions" {
  description = "Permissions for keys"
  type        = list(string)
  default     = ["Get"]
}

variable "secret_permissions" {
  description = "Permissions for secrets"
  type        = list(string)
  default     = ["Get"]
}

variable "certificate_permissions" {
  description = "Permissions for certificates"
  type        = list(string)
  default     = ["Get"]
}
