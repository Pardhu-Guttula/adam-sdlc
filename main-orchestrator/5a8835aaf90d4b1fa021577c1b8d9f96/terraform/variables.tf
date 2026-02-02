variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "example-resources"
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan to create."
  type        = string
  default     = "example-appserviceplan"
}

variable "app_service_name" {
  description = "The name of the App Service to create."
  type        = string
  default     = "example-appservice"
}

variable "function_app_name" {
  description = "The name of the Function App to create."
  type        = string
  default     = "example-functionapp"
}

variable "storage_account_name" {
  description = "The name of the Storage Account to create."
  type        = string
  default     = "examplestorageacc"
}