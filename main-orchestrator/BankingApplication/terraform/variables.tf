variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The Azure Region"
  type        = string
  default     = "West Europe"
}
variable "admin_login" {
  description = "The SQL admin login name"
  type        = string
}
variable "admin_password" {
  description = "The SQL admin password"
  type        = string
}
variable "log_analytics_workspace_sku" {
  description = "The SKU of the Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}
