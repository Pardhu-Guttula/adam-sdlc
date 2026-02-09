variable "azure_location" {
  description = "The location of the azure resources."
  type        = string
}

variable "azure_rg" {
  description = "The name of the resource group in Azure."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "google_project" {
  description = "The Google project ID."
  type        = string
}

variable "google_region" {
  description = "The Google cloud region to create resources in."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
}

variable "principal_id" {
  description = "The principal ID for the role assignment."
  type        = string
}