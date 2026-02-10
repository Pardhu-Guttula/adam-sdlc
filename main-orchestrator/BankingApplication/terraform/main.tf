terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "web_app" {
  name                = "example-webapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    application_stack {
      node_version = "14-lts"
    }
  }
}

resource "azurerm_api_management" "api_management" {
  name                = "example-api-management"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "Example Corp"
  publisher_email     = "api@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "example_api" {
  name                = "example-api"
  resource_group_name = azurerm_resource_group.example.name
  api_management_name = azurerm_api_management.api_management.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]
}

resource "azurerm_api_management_authorization_server" "example_auth_server" {
  name                         = "example-oauth2"
  resource_group_name          = azurerm_resource_group.example.name
  api_management_name          = azurerm_api_management.api_management.name
  authorization_endpoint       = "https://example.com/oauth2/authorize"
  token_endpoint               = "https://example.com/oauth2/token"
  client_registration_endpoint = "https://example.com/oauth2/register"
  grant_types                  = ["authorizationCode"]
  authorization_methods        = ["HEAD", "OPTIONS", "TRACE"]
  client_authentication_method = ["POST"]
  token_body_parameters        = [{ name = "resource", value = "{baseUrl}" }]
}

resource "azurerm_application_insights" "example" {
  name                = "example-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-loganalytics"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "example-diagnostic-setting"
  target_resource_id         = azurerm_api_management.api_management.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  enabled_log {
    category = "GatewayLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_role_assignment" "example" {
  principal_id   = "<principal_id>"
  role_definition_name = "Contributor"
  scope          = azurerm_resource_group.example.id
}