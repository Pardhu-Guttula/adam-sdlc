variable "resource_group_name" {
  description = "The name of the resource group to create or use"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}