variable "azure_location" {
  description = "The location/region where the Azure resources should be created."
  type        = string
  default     = "East US"
}

variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "google_project" {
  description = "The GCP project ID for resource creation."
  type        = string
}

variable "google_region" {
  description = "The GCP region where resources will be created."
  type        = string
  default     = "us-central1"
}

variable "ibm_location" {
  description = "The IBM Cloud location where resources will be created."
  type        = string
  default     = "us-south"
}