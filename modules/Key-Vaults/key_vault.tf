data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  # soft_delete_enabled = true
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled = var.purge_protection_enabled
}
