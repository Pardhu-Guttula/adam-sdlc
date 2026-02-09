variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in Azure."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the storage account for cost export in Azure."
  type        = string
}

variable "recurrence_year" {
  description = "The year for the recurrence of cost export in Azure."
  type        = number
}
