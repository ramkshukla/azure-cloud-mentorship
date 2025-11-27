terraform {
  backend "azurerm" {
    resource_group_name  = "Week1-RG"
    storage_account_name = "tfstatermk"
    container_name       = "tfstate"
    key                  = "capstone.tfstate"
  }
}