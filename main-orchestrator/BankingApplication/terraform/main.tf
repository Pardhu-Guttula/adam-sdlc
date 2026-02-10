terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_sql_server" "sql" {
  name                = "sql-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "12.0"
  administrator_login = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "sqldb" {
  name                = "sqldb-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name
  requested_service_objective_name = "S0"
}

resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "cosmos-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}

resource "azurerm_storage_account" "storage" {
  name                     = "stor${var.prefix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_function_app" "function" {
  name                       = "function-${var.prefix}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
}

resource "azurerm_logic_app_workflow" "logicapp" {
  name                = "logicapp-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_api_management" "apim" {
  name                = "apim-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "Developer_1"
}

resource "azurerm_key_vault" "keyvault" {
  name                       = "kv-${var.prefix}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
}

resource "azurerm_role_assignment" "example" {
  principal_id         = data.azurerm_client_config.current.service_principal_object_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.rg.id
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = var.diagnostic_setting_name
  target_resource_id = azurerm_app_service.app.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.example.id
  enabled_log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_application_insights" "appinsights" {
  name                = "appinsights-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_cdn_profile" "cdn" {
  name                = "cdn-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "cdnendpoint-${var.prefix}"
  profile_name        = azurerm_cdn_profile.cdn.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  origin {
    name      = "app-origin"
    host_name = azurerm_app_service.app.default_site_hostname
  }
}

resource "azurerm_sendgrid_account" "sendgrid" {
  name                = "sendgrid-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  username            = var.sendgrid_username
  password            = var.sendgrid_password
  tier                = "free"
}

resource "azurerm_notification_hub" "notificationhub" {
  name                = "notificationhub-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  namespace_name      = "namespace-${var.prefix}"
}
