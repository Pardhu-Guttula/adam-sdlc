variable "location" {
  description = "The Azure region to deploy to."
  type        = string
  default     = "East US"
}

variable "sql_admin_username" {
  description = "The username of the SQL administrator user."
  type        = string
}

variable "sql_admin_password" {
  description = "The password of the SQL administrator user."
  type        = string
  sensitive   = true
}

variable "principal_id" {
  description = "The principal ID for RBAC assignment."
  type        = string
}
