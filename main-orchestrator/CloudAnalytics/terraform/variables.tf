variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
}

variable "resource_group_name" {
  description = "The Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}
