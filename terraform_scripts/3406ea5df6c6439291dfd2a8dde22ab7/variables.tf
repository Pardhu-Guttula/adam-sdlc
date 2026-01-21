variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure Region where the resources should be created."
  type        = string
  default     = "East US"
}

variable "sql_admin_user" {
  description = "Administrator username for SQL Server."
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Administrator password for SQL Server."
  type        = string
  default     = "P@ssw0rd1234"
}
