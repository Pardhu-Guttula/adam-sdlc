variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure Region"
  type        = string
  default     = "West Europe"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}

variable "sql_admin_username" {
  description = "The admin username for SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for SQL server"
  type        = string
  sensitive   = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  type        = string
}
