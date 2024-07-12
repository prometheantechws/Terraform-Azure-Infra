# Used in AKS Module.
data "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks-stage"
  virtual_network_name = module.Vnet.vnet_names["vnet2"]
  resource_group_name  = module.RG.RG_name
  depends_on           = [module.Vnet]
}
