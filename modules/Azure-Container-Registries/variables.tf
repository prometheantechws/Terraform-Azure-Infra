// acr_module/variables.tf

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "acr_name" {
  description = "The name of the ACR."
  type        = string
}

variable "sku" {
  description = "The SKU of the ACR."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin access to ACR."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public access to ACR."
  type = bool
  default = false
}