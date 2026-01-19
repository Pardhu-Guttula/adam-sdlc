provider "azurerm" {
  features {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  location                 = azurerm_resource_group.example.location
  resource_group_name      = azurerm_resource_group.example.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "examplesqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "example" {
  name                = "examplename"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  requested_service_objective_name = "S0"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "examplecosmosdb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}

resource "azurerm_function_app" "example" {
  name                      = "examplefunctionapp"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  app_service_plan_id       = azurerm_app_service_plan.example.id
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}

resource "azurerm_api_management" "example" {
  name                = "exampleapim"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "My Company"
  publisher_email     = "company@example.com"
}

resource "azurerm_logic_app" "example" {
  name                = "examplelogicapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_key_vault" "example" {
  name                = "examplekeyvault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

resource "azurerm_security_center_contact" "example" {
  email = "contact@example.com"
  phone = "000-111-2222"
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "examplediagnostic"
  target_resource_id         = azurerm_resource_group.example.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "Administrative"
    enabled  = true
  }

  enabled_log {
    category = "Security"
    enabled  = true
  }

  enabled_log {
    category = "ServiceHealth"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
