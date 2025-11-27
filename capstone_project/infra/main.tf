resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

locals {
  suffix      = random_integer.suffix.result
  name_prefix = "${var.prefix}-${local.suffix}"

  tags = {
    Environment = "Dev"
    Owner       = var.owner
    Project     = "CloudCapstone"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "sa" {
  name = substr(
    lower(
      replace("${local.name_prefix}sa", "/[^a-z0-9]/", "")
    ),
    0,
    24
  )

  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  allow_nested_items_to_be_public = true

  tags = local.tags
}

resource "azurerm_storage_container" "web" {
  name                  = "$web"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "blob"
}

resource "azurerm_storage_account_static_website" "static" {
  storage_account_id = azurerm_storage_account.sa.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "../app/index.html"
}

resource "azurerm_storage_blob" "error" {
  name                   = "404.html"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "../app/404.html"
}

resource "azurerm_storage_blob" "style" {
  name                   = "style.css"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "../app/style.css"

  content_type = "text/css"
}


