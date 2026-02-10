variable "location" {
  description = "The location where resources will be created."
  type        = string
  default     = "East US"
}

variable "sql_admin_username" {
  description = "The admin username for the SQL Server."
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for the SQL Server."
  type        = string
  sensitive   = true
}
