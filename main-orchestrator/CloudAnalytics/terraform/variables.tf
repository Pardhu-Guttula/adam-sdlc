variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The location where the resources will be created."
}

variable "aad_domain_name" {
  description = "The name of the Azure Active Directory domain."
}

variable "sql_server_name" {
  description = "The name of the Azure SQL Server."
}

variable "sql_administrator_login" {
  description = "The administrator login for the Azure SQL Server."
}

variable "sql_administrator_password" {
  description = "The administrator password for the Azure SQL Server."
}

variable "cosmosdb_account_name" {
  description = "The name of the Cosmos DB account."
}

variable "security_center_tier" {
  description = "The pricing tier of the Security Center."
}

variable "policy_assignment_name" {
  description = "The name of the policy assignment."
}

variable "policy_definition_id" {
  description = "The ID of the policy definition."
}

variable "policy_description" {
  description = "The description of the policy."
}

variable "policy_display_name" {
  description = "The display name of the policy."
}

variable "cost_management_export_name" {
  description = "The name of the cost management export."
}

variable "subscription_id" {
  description = "The subscription ID for the export scope."
}

variable "storage_account_id" {
  description = "The ID of the storage account for the export."
}

variable "recurrence_from" {
  description = "The start date for the recurrence period."
}

variable "recurrence_to" {
  description = "The end date for the recurrence period."
}

variable "devops_project_name" {
  description = "The name of the DevOps project."
}

variable "devops_project_description" {
  description = "The description of the DevOps project."
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace."
}
