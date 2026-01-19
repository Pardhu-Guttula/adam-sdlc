variable "sql_admin_username" {
  description = "The administrator username for SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for SQL Server"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The ID of the tenant that should be used for authenticating requests to the Key Vault."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace that should be used for diagnostic setting."
  type        = string
}
