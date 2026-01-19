variable "sql_admin_username" {
  description = "The administrator username for the SQL server."
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server. This must adhere to the Azure SQL password policies."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for the Azure Key Vault."
  type        = string
}
