variable "peerings" {
  description = "A map of VNET peering configurations"
  type = map(object({
    name                      = string
    resource_group_name       = string
    vnet1_name                = string
    vnet2_id                  = string
    vnet2_name                = string
    vnet1_id                  = string
    allow_forwarded_traffic   = bool
    allow_gateway_transit     = bool
    use_remote_gateways       = bool
    allow_virtual_network_access = bool
  }))
}
