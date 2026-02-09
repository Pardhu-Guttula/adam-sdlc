variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "East US"
}

variable "sql_admin_username" {
  description = "The username for the SQL Server administrator."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL Server administrator."
  type        = string
  sensitive   = true
}

variable "b2c_directory_name" {
  description = "The name of the Azure B2C Directory."
  type        = string
}
