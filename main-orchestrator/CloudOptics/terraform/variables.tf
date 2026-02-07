variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
  default     = "P@ssw0rd1234"
}
