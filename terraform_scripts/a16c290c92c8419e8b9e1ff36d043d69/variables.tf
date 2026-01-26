variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure Region where the resources will be deployed"
  type        = string
}

variable "sql_password" {
  description = "The admin password for the SQL server"
  type        = string
  sensitive   = true
}
