variable "dns_zone_name" {
  description = "The name of the Private DNS Zone."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}


variable "virtual_network_links" {
  description = "List of virtual network links"
  type        = map(object({
    name              = string
    virtual_network_id = string
    registration_enabled = bool
  }))
}