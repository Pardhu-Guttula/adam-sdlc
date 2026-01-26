provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = "example-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "example-app"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    dotnet_framework_version = "v4.0"
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appinsights.instrumentation_key
  }
}

resource "azurerm_application_insights" "appinsights" {
  name                = "example-ai"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
}

resource "azurerm_sql_server" "sql" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_password
}

resource "azurerm_sql_database" "sqldb" {
  name                = "example-sqldb"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = azurerm_sql_server.sql.name
  requested_service_objective_name = "S1"
}

resource "azurerm_storage_account" "storacc" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_signalr_service" "signalr" {
  name                = "example-signalr"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    name     = "Standard_S1"
    capacity = 1
  }
}

resource "azurerm_api_management" "api" {
  name                = "example-api"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "pub1"
  publisher_email     = "pub@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_logic_app" "logic" {
  name                = "example-logic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}
