variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "main-resource-group"
}

variable "location" {
  description = "Location where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "ad_b2c_directory_name" {
  description = "Azure Active Directory B2C Directory Name."
  type        = string
  default     = "myb2cdir"
}
