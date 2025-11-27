output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "static_website_url" {
  value = azurerm_storage_account.sa.primary_web_endpoint
}

output "keyvalut_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "log_analytics_ws_id" {
  value = azurerm_log_analytics_workspace.law.id
}