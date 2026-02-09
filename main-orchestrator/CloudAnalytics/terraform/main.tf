terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "~> 2.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project
}

provider "ibm" {}

resource "aws_iam_role" "example" {
  name               = "example-role"
  assume_role_policy = var.assume_role_policy
}

resource "azurerm_role_assignment" "example" {
  scope                = var.subscription_id
  role_definition_name = "Owner"
  principal_id         = var.principal_id
}

resource "google_service_account" "default" {
  account_id   = "service-account"
  display_name = "Service Account"
}

resource "ibm_iam_policy" "example" {
  name         = "example-polency"
  description  = "Example policy"
  policy_type  = "access"
  policy_roles = ["Editor"]
  policy_subjects = [
    {
      attribute   = "iam_id"
      value       = var.ibm_iam_id
    }
  ]
}