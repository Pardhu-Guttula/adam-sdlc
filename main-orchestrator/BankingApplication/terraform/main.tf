provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
}

resource "azurerm_app_service_plan" "frontend" {
  name                = "frontend-appservice-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "App"
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "frontend" {
  name                = "frontend-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.frontend.id
}

resource "azurerm_traffic_manager_profile" "frontend" {
  name                = "frontend-traffic-manager"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  profile_status      = "Enabled"
  traffic_routing_method = "Performance"
  dns_config {
    relative_name = "frontend-traffic-manager"
    ttl           = 60
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "frontend" {
  name                = "frontend-app-endpoint"
  resource_group_name = azurerm_resource_group.example.name
  traffic_manager_profile_name = azurerm_traffic_manager_profile.frontend.name
  type                = "azureEndpoints"
  target_resource_id  = azurerm_app_service.frontend.id
}
