variable "resource_group_name" {
  description = "The name of the resource group in which resources are created."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "East US"
}
