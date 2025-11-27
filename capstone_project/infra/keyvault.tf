resource "azurerm_key_vault" "kv" {
  name                        = "kv-${local.suffix}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id          = data.azurerm_client_config.current.tenant_id
    object_id          = data.azurerm_client_config.current.object_id
    secret_permissions = ["Get", "List", "Set"]
  }
}

resource "random_password" "db_pass" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = random_password.db_pass.result
  key_vault_id = azurerm_key_vault.kv.id
}
