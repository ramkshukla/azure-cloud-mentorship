data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "week7-tf-rg"
  location = "eastus"
}

resource "azurerm_storage_account" "sa" {
  name                     = "week7tfsa12345"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "tfcontainer"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_service_plan" "asp" {
  name                = "week7-asp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "B1"
  os_type             = "Linux"

}

resource "azurerm_linux_web_app" "webapp" {
  name                = "week7webapp12345"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

}

