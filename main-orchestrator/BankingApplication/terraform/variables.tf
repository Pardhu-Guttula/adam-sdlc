variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "sql_admin_password" {
  description = "The password of the SQL server administrator."
  type        = string
  sensitive   = true
}

variable "key_vault_secret_value" {
  description = "The value to be stored in the Key Vault as a secret."
  type        = string
  sensitive   = true
}
