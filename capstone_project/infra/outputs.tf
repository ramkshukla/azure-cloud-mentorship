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



# Output
keyvalut_uri = "https://kv-6624.vault.azure.net/"
log_analytics_ws_id = "/subscriptions/ac6e8c49-833e-427d-bcc4-87042af5ddaf/resourceGroups/capstone-6624-rg/providers/Microsoft.OperationalInsights/workspaces/capstone-6624-law"
resource_group_name = "capstone-6624-rg"
static_website_url = "https://capstone6624sa.z13.web.core.windows.net/"