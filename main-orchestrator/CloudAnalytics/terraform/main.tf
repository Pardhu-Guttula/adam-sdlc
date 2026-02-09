terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.google_project
  region  = var.google_region
}

provider "ibm" {
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.azure_location
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
  acl    = "private"
}

resource "google_storage_bucket" "example" {
  name     = "example-bucket"
  location = var.google_region
}

resource "ibm_resource_instance" "example" {
  name          = "example-instance"
  service       = "cloud-object-storage"
  plan          = "lite"
  location      = var.ibm_location
  resource_group = "Default"
}