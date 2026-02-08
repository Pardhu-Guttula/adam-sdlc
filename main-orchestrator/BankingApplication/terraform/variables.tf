variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service plan"
  type        = string
}

variable "web_app_name" {
  description = "Name of the Web App"
  type        = string
}

variable "app_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
}

variable "diagnostic_setting_name" {
  description = "Name of the Diagnostic Setting"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_admin_username" {
  description = "Administrator username for the SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "redis_cache_name" {
  description = "Name of the Redis cache instance"
  type        = string
}
