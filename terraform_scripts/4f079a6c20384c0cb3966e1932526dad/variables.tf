variable "sql_admin_user" {
  description = "The administrator username for SQL Database."
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for SQL Database."
  type        = string
  sensitive   = true
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile."
  type        = string
}

variable "origin_hostname" {
  description = "Hostname for the origin."
  type        = string
}

variable "namespace_name" {
  description = "The notification hub namespace."
  type        = string
}