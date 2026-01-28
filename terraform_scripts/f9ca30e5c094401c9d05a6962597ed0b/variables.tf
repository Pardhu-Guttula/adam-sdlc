variable "location" {
  description = "The Azure location to deploy resources."
  type        = string
  default     = "West Europe"
}

variable "sql_admin_username" {
  description = "The username for the SQL server administrator."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL server administrator."
  type        = string
  sensitive   = true
}
