provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_application_insights" "example" {
  name                = "example-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-app-service"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    application_insights_connection_string = azurerm_application_insights.example.connection_string
    always_on = true
  }
}

resource "azurerm_function_app" "example" {
  name                       = "example-function-app"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  application_insights_id    = azurerm_application_insights.example.id
  storage_connection_string  = azurerm_storage_account.example.primary_connection_string
  os_type                    = "linux"
  version                    = "~3"
  site_config {
    application_insights_connection_string = azurerm_application_insights.example.connection_string
  }
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "example-cosmos-db"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix   = 200
  }
}

resource "azurerm_sql_server" "example" {
  name                         = "example-sql-server"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "example" {
  name                = "example-sql-db"
  resource_group_name = azurerm_sql_server.example.resource_group_name
  location            = azurerm_sql_server.example.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "Basic"
}

resource "azurerm_key_vault" "example" {
  name                = "example-key-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.example.tenant_id
  object_id    = data.azurerm_client_config.example.object_id
}

resource "azurerm_key_vault_key" "example" {
  name        = "example-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type    = "RSA"
  key_size    = 2048
}

resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = var.key_vault_secret_value
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_active_directory_domain_service" "example" {
  name                = "example-adds"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  domain_name         = "example.com"
}
