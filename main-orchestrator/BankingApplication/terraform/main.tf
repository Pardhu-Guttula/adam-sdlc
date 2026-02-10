provider "azurerm" {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
  features {}
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
resource "azurerm_app_service" "example" {
  name                = "example-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}
resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_sql_server" "example" {
  name                         = "example-sql-server"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "adminlogin"
  administrator_login_password = "H@Sh1CoR3!"
}
resource "azurerm_sql_database" "example" {
  name                = "example-sql-database"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  requested_service_objective_name = "S0"
}
resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "example"
  target_resource_id         = azurerm_app_service.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  enabled_log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
}
resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
}
resource "azurerm_role_assignment" "example" {
  scope                = azurerm_resource_group.example.id
  role_definition_name = "Contributor"
  principal_id         = "<principal_ID>"
}
resource "azurerm_monitor_metric_alert" "example" {
  name                = "example"
  resource_group_name = azurerm_resource_group.example.name
  scopes              = [azurerm_app_service.example.id]
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1
  }
}
resource "azurerm_dev_test_lab" "example" {
  name                = "example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}