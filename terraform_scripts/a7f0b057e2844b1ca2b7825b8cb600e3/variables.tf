variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "sql_admin_username" {
  description = "The SQL server admin username."
  type        = string
}

variable "sql_admin_password" {
  description = "The SQL server admin password."
  type        = string
  sensitive   = true
}

variable "publisher_name" {
  description = "The name of the API Management publisher."
  type        = string
}

variable "publisher_email" {
  description = "The email of the API Management publisher."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID."
  type        = string
}

variable "notification_namespace" {
  description = "The namespace for the notification hub."
  type        = string
}

variable "logic_app_definition" {
  description = "The definition of the logic app workflow."
  type        = string
}
