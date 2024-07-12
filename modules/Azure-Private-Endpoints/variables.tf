variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint"
  type        = string
}

variable "private_service_connections" {
  description = "The private link service connection details"
  type        = map(object({
    name                           = string
    private_connection_resource_id = string
    subresource_names              = list(string)
    is_manual_connection           = bool
  }))
}

variable "private_dns_zone_group_name" {
  description = "Private dns zone group name"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "Private dns zone IDs"
  type        = list(string)
}