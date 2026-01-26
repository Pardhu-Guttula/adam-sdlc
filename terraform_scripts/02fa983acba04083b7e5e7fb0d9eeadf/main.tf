provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "example-appservice"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

resource "azurerm_api_management" "api_management" {
  name                = "example-api-mgmt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_domain    = "example.com"
  publisher_name      = "Example"
  sku_name            = "Developer_1"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = "example-sqldatabase"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "S1"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                = "example-cosmosdb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
}

resource "azurerm_key_vault" "key_vault" {
  name                       = "example-kv"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
}

resource "azurerm_monitor_diagnostic_setting" "diag_setting" {
  name                        = "example-diagnostic-setting"
  target_resource_id          = azurerm_app_service.app_service.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.example.id
  enabled_log {
    category = "AppServiceHTTPLogs"
  }
  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-loganalytics"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
}

resource "azurerm_security_center_contact" "example" {
  email = var.security_center_contact_email
}

output "app_service_default_site_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "sql_server_fqdn" {
  value = azurerm_sql_server.sql_server.fully_qualified_domain_name
}
