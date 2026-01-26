provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "selfservicebanking-rg"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "frontend-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    always_on = true
  }
  app_settings = {
    "SOME_KEY" = "some_value"
  }
}

resource "azurerm_key_vault" "keyvault" {
  name                = "kv-mfa"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = "sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_password
}

resource "azurerm_sql_database" "sqldatabase" {
  name                = "sqldatabase"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  sku_name            = "S0"
}

resource "azurerm_monitor_diagnostic_setting" "monitor" {
  name               = "monitor-settings"
  target_resource_id = azurerm_resource_group.rg.id
  eventhub_authorization_rule_id = ""
  eventhub_name                = "eventhub"
  log_analytics_workspace_id   = ""
  enabled_log {
    category = "Administrative"
  }
  metric {
    category = "AllMetrics"
  }
}
