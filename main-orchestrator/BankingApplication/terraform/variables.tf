variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "sql_admin_username" {
  description = "The SQL server administrator username"
  type        = string
}

variable "sql_admin_password" {
  description = "The SQL server administrator password"
  type        = string
  sensitive   = true
}