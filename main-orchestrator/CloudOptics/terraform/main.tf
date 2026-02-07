provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = "app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_front_door" "fd" {
  name                = "front-door"
  resource_group_name = azurerm_resource_group.rg.name
  frontend_endpoint {
    name      = "frontend-endpoint"
    host_name = "frontend.contoso.com"
  }
  backend_pool {
    name = "backend-pool"
    backend {
      host_header = azurerm_app_service.app.default_site_hostname
      address = azurerm_app_service.app.default_site_hostname
      http_port  = 80
      https_port = 443
    }
    load_balancing {
      additional_latency_milliseconds = 0
    }
    health_probe {
      path     = "/"
      protocol = "Http"
    }
  }
  routing_rule {
    name               = "route1"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = [azurerm_front_door.fd.frontend_endpoint.name]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = azurerm_front_door.fd.backend_pool.name
    }
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                = "myVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size             = "Standard_D2_v2"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  os_profile {
    computer_name  = "hostname"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name              = "myManagedOSDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_aks_cluster" "aks" {
  name                = "aksCluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdns"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "primary-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = "subnet-id"
    private_ip_address_allocation = "Dynamic"
  }
}
