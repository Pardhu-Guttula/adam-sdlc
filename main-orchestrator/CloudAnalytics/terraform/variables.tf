variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

variable "azure_location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "West US"
}

variable "gcp_project" {
  description = "The GCP project to deploy resources in."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources in."
  type        = string
  default     = "us-central1"
}
