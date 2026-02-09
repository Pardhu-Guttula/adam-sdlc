variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "main-resource-group"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}

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
  description = "The tenant ID for the subscription"
  type        = string
}
