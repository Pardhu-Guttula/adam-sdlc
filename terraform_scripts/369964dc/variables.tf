variable "sql_admin_username" {
  description = "The administrator username for the SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Tenant ID for the Key Vault"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID for Diagnostic Settings"
  type        = string
}
