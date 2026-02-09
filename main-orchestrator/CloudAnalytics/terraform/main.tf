terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_active_directory_domain_service" "example" {
  name                = var.aad_domain_name
  resource_group_name = var.resource_group_name
  location            = var.location
  domain_name         = var.aad_domain_name
  sku                 = "Standard"
}

resource "azurerm_sql_server" "example" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_password
}

resource "azurerm_cosmosdb_account" "example" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "BoundedStaleness"
  }
}

resource "azurerm_security_center_subscription_pricing" "example" {
  tier = var.security_center_tier
}

resource "azurerm_policy_assignment" "example" {
  name                 = var.policy_assignment_name
  scope                = azurerm_resource_group.example.id
  policy_definition_id = var.policy_definition_id
  description          = var.policy_description
  display_name         = var.policy_display_name
}

resource "azurerm_cost_management_export" "example" {
  name                = var.cost_management_export_name
  scope               = var.subscription_id
  storage_account_id  = var.storage_account_id
  recurrence_period {
    from = var.recurrence_from
    to   = var.recurrence_to
  }
}

resource "azurerm_devops_project" "example" {
  name                = var.devops_project_name
  description         = var.devops_project_description
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}
