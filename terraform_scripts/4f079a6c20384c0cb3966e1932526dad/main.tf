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
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-appservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_function_app" "example" {
  name                = "example-functionapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  storage_connection_string = azurerm_storage_account.example.primary_connection_string
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "example" {
  name                = "example-sqldb"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "S1"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "example-cosmosdb"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}

resource "azurerm_key_vault" "example" {
  name                = "example-keyvault"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_logic_app" "example" {
  name                = "example-logicapp"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_servicebus_namespace" "example" {
  name                = "example-sbnamespace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
}

resource "azurerm_cdn_profile" "example" {
  name                = "example-cdnprofile"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_Akamai"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "example-cdnendpoint"
  profile_name        = var.cdn_profile_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  origin {
    name      = var.origin_hostname
    host_name = azurerm_app_service.example.default_site_hostname
  }
}

resource "azurerm_traffic_manager_profile" "example" {
  name                = "example-traffmanager"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  dns_config {
    relative_name = "example"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "example" {
  name                = "example-endpoint"
  resource_group_name = azurerm_resource_group.example.name
  profile_name        = azurerm_traffic_manager_profile.example.name
  type                = "azureEndpoints"
  target_resource_id  = azurerm_app_service.example.id
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example-diagnostics"
  target_resource_id = azurerm_app_service.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  enabled_log {
    category = "AppServiceHTTPLogs"
    enabled = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_notification_hub" "example" {
  name                = "example-notificationhub"
  location            = azurerm_resource_group.example.location
  namespace_name      = var.namespace_name
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_notification_hub_namespace" "example" {
  name                = "example-namespacenotification"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
}