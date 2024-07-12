variable "vnets" {
  description = "A map of VNET configurations"
  type = map(object({
    name = string
    address_space       = list(string)
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Name of the location"
}