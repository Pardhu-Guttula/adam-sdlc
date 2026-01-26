provider "azurerm" {
  features {}
}

resource "azurerm_app_service" "frontend" {
  name                = "frontend-web-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_app_service" "web_api" {
  name                = "web-api-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_function_app" "azure_functions" {
  name                = "azure-functions"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "sql-server"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = "sql-database"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "S0"
}

resource "azurerm_api_management" "api_management" {
  name                = "api-management"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "Developer_1"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "storageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = "diagnostic-setting"
  target_resource_id = azurerm_app_service.frontend.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  enabled_log {
    category = "AppServiceHTTPLogs"
  }
  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name                = "traffic-manager"
  resource_group_name = var.resource_group_name
  location            = var.location
  profile_status      = "Enabled"
  traffic_routing_method = "Performance"
}

resource "azurerm_key_vault" "key_vault" {
  name                = "key-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
}

resource "azurerm_notification_hub" "notification_hub" {
  name                = "notification-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  namespace_name      = var.notification_namespace
}

resource "azurerm_logic_app" "logic_app" {
  name                = "logic-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  workflow {
    definition = var.logic_app_definition
  }
}
