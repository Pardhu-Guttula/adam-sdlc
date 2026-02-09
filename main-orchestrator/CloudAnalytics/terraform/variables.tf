variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "gcp_project" {
  description = "GCP project ID"
  type        = string
}

variable "assume_role_policy" {
  description = "IAM assume role policy"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "principal_id" {
  description = "Azure Principal ID"
  type        = string
}

variable "ibm_iam_id" {
  description = "IBM IAM ID"
  type        = string
}
