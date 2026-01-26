variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure region to use"
  type        = string
  default     = "West Europe"
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "sql_administrator_login" {
  description = "The administrator login for the SQL server"
  type        = string
}

variable "sql_administrator_password" {
  description = "The administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key"
  type        = string
}
