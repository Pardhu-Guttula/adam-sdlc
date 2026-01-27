terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_key_vault" "example" {
  name                = "examplekeyvault123"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "standard"
}

resource "azurerm_frontdoor" "example" {
  name                = "examplefrontdoor"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  enforce_backend_pools_certificate_name_check  = false
}

resource "azurerm_active_directory_domain_service" "example" {
  name                 = "exampledomain.com"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  domain_name          = "example.com"
  forest_mode          = "UserForest"
}

resource "azurerm_mfa" "example" {
  name                 = "examplemfa"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
}