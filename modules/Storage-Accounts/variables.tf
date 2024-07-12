variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The name of the location"
  type        = string
}

variable "account_tier" {
  description = "The name of the account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The name of the account replication type"
  type        = string
  default     = "LRS"
}

variable "public_network_access_enabled" {
  description = "Enable or Disable the public network access"
  type = bool
}
