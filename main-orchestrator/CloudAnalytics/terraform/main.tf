terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.google_project
  region  = var.google_region
}

resource "azurerm_app_service_plan" "asp" {
  name                = "example-appserviceplan"
  location            = var.azure_location
  resource_group_name = var.azure_rg
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "example-app"
  location            = var.azure_location
  resource_group_name = var.azure_rg
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    dotnet_framework_version = "v4.0"
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "example"
  target_resource_id         = azurerm_app_service.app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  enabled_log {
    category      = "AppServiceHTTPLogs"
    enabled       = true
    retention_policy_days = 0
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy_days = 0
  }
}

resource "azurerm_role_assignment" "example" {
  principal_id   = var.principal_id
  role_definition_name = "Contributor"
  scope          = azurerm_app_service.app.id
}