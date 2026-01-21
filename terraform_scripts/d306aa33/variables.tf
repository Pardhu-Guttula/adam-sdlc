variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
  default     = "East US"
}
