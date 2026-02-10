provider "azurerm" {
  features {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_app_service" "frontend_app" {
  name                = "myAppService"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  site_config {
    always_on                 = true
    dotnet_framework_version  = "v4.0"
  }
}

resource "azurerm_traffic_manager_profile" "frontend_traffic" {
  name                = "myTrafficManager"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "global"
  profile_status      = "Enabled"
  traffic_routing_method = "Performance"
  dns_config {
    relative_name    = "myTrafficManager"
    ttl              = 30
  }
  monitor_config {
    protocol         = "HTTP"
    port             = 80
    path             = "/"
  }
}

resource "azurerm_application_gateway" "userexp_gateway" {
  name                = "myAppGateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "myGatewayIpConfig"
    subnet_id = azurerm_subnet.subnet.id
  }
  frontend_port {
    name = "frontendPort"
    port = 80
  }
  frontend_ip_configuration {
    name                 = "frontendIpConfig"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  backend_address_pool {
    name = "backendAddressPool"
  }
  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIpConfig"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }
  url_path_map {
    name                = "urlPathMap"
    default_backend_address_pool_name = "backendAddressPool"
    default_redirect_configuration {
      redirect_type = "Found"
      target_url    = "https://example.com"
    }
  }
}

resource "azurerm_cdn_profile" "userexp_cdn" {
  name                = "myCdnProfile"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "myCdnEndpoint"
  profile_name        = azurerm_cdn_profile.userexp_cdn.name
  resource_group_name = azurerm_resource_group.rg.name
  origin {
    name      = "cdn-origin"
    host_name = azurerm_app_service.frontend_app.default_site_hostname
  }
  delivery_rule_cache_expiration_action {
    name                   = "no-store"
    match_condition_list {
      match_variable  = "UrlPath"
      operator        = "Any"
    }
    parameters {
      cache_behavior = "BypassCache"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "myPublicIp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
