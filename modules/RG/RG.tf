resource "azurerm_resource_group" "RG" {
  name     = var.resource_group_name
  location = var.location
  # tags = var.tags
}
