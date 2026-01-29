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

resource "azurerm_function_app" "functions" {
  name                = "my-functions"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id
  storage_account_name = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  version             = "~2"
}

resource "azurerm_app_service" "api_app" {
  name                = "my-api-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id

  site_config {
    always_on                  = true
    linux_fx_version           = "NODE|14-lts"
    app_command_line           = "npm start"
  }
}

resource "azurerm_mysql_server" "mysql" {
  name                = "my-sql-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B_Gen5_2"
  administrator_login = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  storage_mb          = 5120
  version = "5.7"
}

resource "azurerm_key_vault" "key_vault" {
  name                = "mykeyvault"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
}

resource "azurerm_api_management" "api_management" {
  name                = "my-api-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "MyAPI"
  publisher_email     = "api@myapi.com"
  sku_name            = "Developer_1"
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  name               = "my-diagnostic-setting"
  target_resource_id = join("", [azurerm_api_management.api_management.id, azurerm_function_app.functions.id, azurerm_app_service.api_app.id, azurerm_key_vault.key_vault.id])

  enabled_log {
    category        = "Administrative"
    enabled         = true
    retention_policy_days = 0
  }

  metric {
    category        = "AllMetrics"
    enabled         = true
    retention_policy_days = 0
  }
}

resource "azurerm_notification_hub" "notification_hub" {
  name                = "my-notification-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = "my-notification-namespace"
}

resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "East US"
}

resource "azurerm_app_service_plan" "service_plan" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_ddos_protection_plan" "ddos" {
  name                = "my-ddos"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_logic_app_workflow" "logic_app" {
  name                = "my-logic-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_sql_database" "sql_db" {
  name                = "my-sql-db"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql.name
  sku_name            = "S1"
}

resource "azurerm_storage_blob" "blob_storage" {
  name                   = "myblobstorage"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "blobcontainer"
}
