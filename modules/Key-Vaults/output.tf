output "kv_id" {
  description = "The ID of the KV"
  value       = azurerm_key_vault.kv.id
}

output "kv_tenanet_id" {
  value = data.azurerm_client_config.current.tenant_id
}