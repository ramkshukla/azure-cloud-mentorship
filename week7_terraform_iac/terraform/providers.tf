terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

}

provider "azurerm" {
  features {}
  subscription_id = "ac6e8c49-833e-427d-bcc4-87042af5ddaf"

}