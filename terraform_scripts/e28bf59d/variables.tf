variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "example-appserviceplan"
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
  default     = "example-appservice"
}

variable "storage_account_name" {
  description = "The name of the Storage Account"
  type        = string
  default     = "examplestorageacc"
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default     = "examplekeyvault"
}
