provider "azurerm" {
  features {}
}

resource "azurerm_active_directory_domain_service" "example" {
  name                = "example"
  resource_group_name = "example-resources"
  location            = "West US"
  domain_name         = "example.com"

  sku {
    name = "Standard"
  }

  ldaps_settings {
    external_access_enabled = true
    ldaps {
      enabled = true
      protocol = "Tcp"
      certificate = "---CERTIFICATE---"
    }
  }

  notification_settings {
    notify_global_admins = true
    notify_user_roles    = ["User Administrator"]
  }
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks"
  location            = azurerm_active_directory_domain_service.example.location
  resource_group_name = azurerm_active_directory_domain_service.example.resource_group_name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 1
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_policy_assignment" "example" {
  name                 = "example-policy-assignment"
  scope                = azurerm_active_directory_domain_service.example.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ExamplePolicy"
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "example-diagnostic-setting"
  target_resource_id         = azurerm_active_directory_domain_service.example.id
  log_analytics_workspace_id = "/subscriptions/XXX/resourceGroups/YYY/providers/Microsoft.OperationalInsights/workspaces/ZZZ"
  enabled_log {
    category = "Administrative"
    enabled  = true
    retention_policy_days = 0
  }
}

resource "azurerm_key_vault" "example" {
  name                = "examplekv"
  location            = azurerm_active_directory_domain_service.example.location
  resource_group_name = azurerm_active_directory_domain_service.example.resource_group_name
  tenant_id           = "${var.tenant_id}"
  sku {
    name = "standard"
  }
}
