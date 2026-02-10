variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}

variable "app_service_plan_id" {
  description = "The App Service plan ID"
  type        = string
}

variable "sql_admin_login" {
  description = "The SQL server administrator login"
  type        = string
}

variable "sql_admin_password" {
  description = "The SQL server administrator password"
  type        = string
  sensitive   = true
}

variable "role_principal_id" {
  description = "The principal ID for the Azure role assignment"
  type        = string
}
