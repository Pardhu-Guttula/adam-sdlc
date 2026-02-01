terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-appservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_api_management" "example" {
  name                = "example-apim"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "Example"
  publisher_email     = "example@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_function_app" "example" {
  name                = "example-functionapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version             = "~3"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
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
  name                = "examplesqldb"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "S0"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "examplecosmosdb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                   = "example-sql-container"
  resource_group_name    = azurerm_resource_group.example.name
  account_name           = azurerm_cosmosdb_account.example.name
  database_name          = "example-db"
  partition_key_path     = "/mypartitionkey"
  throughput             = 400
}

resource "azurerm_cosmosdb_sql_database" "example" {
  name                = "example-db"
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_cosmosdb_account.example.name
}

resource "azurerm_role_assignment" "example" {
  scope              = azurerm_resource_group.example.id
  role_definition_name ="Contributor"
  principal_id       = "$(az ad group show --group "example-group" --query "objectId" -o tsv)"
}

resource "azurerm_b2c_directory" "example" {
  name     = "example-b2c"
  tenant_id = var.b2c_directory_tenant_id
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example-diagnostic"
  target_resource_id = azurerm_app_service.example.id

  enabled_log {
    category = "AppServiceHTTPLogs"
  }

  metric {
    category = "*"
  }
}
