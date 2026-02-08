variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be deployed."
  type        = string
}

variable "asp_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service."
  type        = string
}

variable "logic_app_name" {
  description = "The name of the Logic App."
  type        = string
}

variable "diag_setting_name" {
  description = "The name of the Diagnostic Setting."
  type        = string
}

variable "law_name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "app_insights_name" {
  description = "The name of the Application Insights."
  type        = string
}