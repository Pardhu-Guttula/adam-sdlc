provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_frontdoor" "example" {
  name                = "example-frontdoor"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "example-cdn"
  profile_name        = azurerm_frontdoor.example.name
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
}

resource "azurerm_app_service" "example" {
  name                = "example-appservice"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_app_service_environment" "example" {
  name                = "example-ase"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  subnet_id           = azurerm_subnet.example.id
}

resource "azurerm_function_app" "example" {
  name                = "example-functionapp"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.example.id
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  dns_prefix          = "exampleaks"
}

resource "azurerm_sql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "H@Sh1CoR3!"
}

resource "azurerm_sql_database" "example" {
  name                = "example-sqldb"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  server_name         = azurerm_sql_server.example.name
  edition             = "Basic"
  requested_service_objective_name = "Basic"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "example-cosmosdb"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
}
