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

resource "azurerm_resource_group" "main_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_plan" {
  name                = "app-service-plan"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "frontend-web-app"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id
}

resource "azurerm_app_service" "backend_service" {
  name                = "backend-service"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id
}

resource "azurerm_function_app" "function_app" {
  name                = "azure-functions"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id
  storage_account_name = azurerm_storage_account.functions_storage.name
  storage_account_access_key = azurerm_storage_account.functions_storage.primary_access_key
  os_type = "linux"
  runtime_stack = "node"
}

resource "azurerm_storage_account" "functions_storage" {
  name                     = "functionsstorage${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.main_rg.name
  location                 = azurerm_resource_group.main_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "key_vault" {
  name                = "key-vault-${random_string.random.result}"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  secret_permissions = [
    "get",
    "list"
  ]
  certificate_permissions = [
    "get",
    "list"
  ]
}

resource "azurerm_ad_b2c_directory" "b2c_directory" {
  name     = var.ad_b2c_directory_name
  location = var.location
}

output "frontend_web_app_url" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "backend_service_url" {
  value = azurerm_app_service.backend_service.default_site_hostname
}
