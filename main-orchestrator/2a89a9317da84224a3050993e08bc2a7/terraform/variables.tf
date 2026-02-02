variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "West Europe"
}

variable "sql_admin_username" {
  description = "Administrator username for Azure SQL"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for Azure SQL"
  type        = string
  sensitive   = true
}