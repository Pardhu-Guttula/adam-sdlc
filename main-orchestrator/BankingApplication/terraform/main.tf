provider 'azurerm' {
  features {}
}

resource 'azurerm_resource_group' 'rg' {
  name     = 'example-resources'
  location = 'East US'
}

resource 'azurerm_storage_account' 'sa' {
  name                     = 'examplestoracc'
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = 'Standard'
  account_replication_type = 'LRS'
}

resource 'azurerm_sql_server' 'sql' {
  name                         = 'sqlserverexample'
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = '12.0'
  administrator_login          = 'sqladmin'
  administrator_login_password = var.sql_password
}

resource 'azurerm_sql_database' 'sqldb' {
  name                = 'mysqldb'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name
  requested_service_objective_name = 'S0'
}

resource 'azurerm_api_management' 'apim' {
  name                = 'example-apim'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = 'My Company'
  publisher_email     = 'company@example.com'
  sku_name            = 'Developer_1'
}

resource 'azurerm_cognitive_account' 'cognitive' {
  name                = 'examplecognitive'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = 'CognitiveServices'
  sku_name            = 'S0'
}

resource 'azurerm_monitor_diagnostic_setting' 'diagnostic' {
  name                       = 'example-diagnostics'
  target_resource_id         = azurerm_sql_server.sql.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  enabled_log {
    category = 'SQLInsights'
  }

  metric {
    category = 'AllMetrics'
  }

}

resource 'azurerm_log_analytics_workspace' 'log' {
  name                = 'example-logs'
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = 'PerGB2018'
  retention_in_days   = 30
}

resource 'azurerm_monitor_metric_alert' 'alert' {
  name                = 'example-alert'
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_sql_server.sql.id]
  description         = 'Action will be triggered on high CPU usage'
  criteria {
    metric_name = 'cpu_percentage'
    aggregation = 'Average'
    operator    = 'GreaterThan'
    threshold   = 90
  }
}

resource 'azurerm_active_directory_domain_service' 'adds' {
  name                = 'example-adds'
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  domain_name         = 'example.com'
  sku                 = 'Standard'
}
