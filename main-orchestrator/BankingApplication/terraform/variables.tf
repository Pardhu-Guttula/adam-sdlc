variable "prefix" {
  description = "Prefix for resources"
  type        = string
  default     = "example"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "sql_admin_username" {
  description = "SQL Administrator Username"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "SQL Administrator Password"
  type        = string
  default     = "P@ssword1234"
}

variable "publisher_name" {
  description = "API Management Publisher Name"
  type        = string
  default     = "publisher"
}

variable "publisher_email" {
  description = "API Management Publisher Email"
  type        = string
  default     = "publisher@example.com"
}

variable "sendgrid_username" {
  description = "SendGrid Username"
  type        = string
  default     = "sendgriduser"
}

variable "sendgrid_password" {
  description = "SendGrid Password"
  type        = string
  default     = "SendGridP@ssword123"
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "diagnostic_setting_name" {
  description = "Name for the diagnostic setting"
  type        = string
  default     = "diagnostic-setting"
}
