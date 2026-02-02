provider "azurerm" {
  features {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "frontend_plan" {
  name                = "frontend-app-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "frontend" {
  name                = "frontend-app-service"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.frontend_plan.id
  site_config {
    always_on = true
  }
}

resource "azurerm_function_app" "backend_api" {
  name                = "backend-api-function"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.frontend_plan.id
  storage_account_name = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  site_config {
    always_on = true
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_api_management" "backend_management" {
  name                = "backend-management"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "Your Company"
  publisher_email     = "company@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "sqlserver${random_integer.suffix.result}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "sql_db" {
  name                = "sqldb"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "S0"
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "cosmosdb${random_integer.suffix.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }
}

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "main" {
  name                     = "storage${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}