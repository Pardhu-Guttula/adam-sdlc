terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
  backend "local" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  name               = "example-diagnostic"
  target_resource_id = azurerm_resource_group.example.id
  enabled_log {
    category = "Administrative"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_security_center_contact" "example" {
  email       = "example@example.com"
  phone       = "+1-555-555-5555"
  alert_notifications = true
  alerts_to_admins    = true
}

resource "azurerm_cost_management_export" "example" {
  name                = "example-export"
  resource_group_name = azurerm_resource_group.example.name
  timeframe           = "Monthly"
  delivery_info {
    destination {
      container {
        resource_id   = azurerm_resource_group.example.id
        name          = "example-container"
      }
    }
  }
}

resource "azurerm_policy_definition" "example" {
  name         = "example-policy"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Example Policy"
  policy_rule = <<POLICY
    {
      "if": {
        "field": "location",
        "equals": "West Europe"
      },
      "then": {
        "effect": "deny"
      }
    }
  POLICY
}
