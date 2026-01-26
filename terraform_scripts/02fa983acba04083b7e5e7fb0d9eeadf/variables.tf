variable "sql_admin_username" {
  description = "The SQL Administrator username."
  type        = string
}

variable "sql_admin_password" {
  description = "The SQL Administrator password."
  type        = sensitive(string)
}

variable "security_center_contact_email" {
  description = "Email contact for Azure Security Center notifications."
  type        = string
}
