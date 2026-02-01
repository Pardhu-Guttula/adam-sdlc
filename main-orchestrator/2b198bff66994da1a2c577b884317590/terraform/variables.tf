variable "sql_admin_username" {
  description = "The administrator username for the SQL server."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL administrator user."
  type        = string
  sensitive   = true
}

variable "b2c_directory_tenant_id" {
  description = "The tenant ID for the Azure AD B2C directory."
  type        = string
}
