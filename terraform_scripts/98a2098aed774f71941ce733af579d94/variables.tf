variable "location" {
  description = "The location where resources will be created"
  default     = "West Europe"
}

variable "sql_admin_username" {
  description = "The admin username for SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for SQL Server"
  type        = string
}

variable "principal_id" {
  description = "The Principal ID for Role Assignment"
  type        = string
}
