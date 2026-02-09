provider "azurerm" {
  features {}
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
  acl    = "private"
}

resource "google_storage_bucket" "example" {
  name                        = "example-bucket"
  location                    = var.gcp_region
  force_destroy               = true
  storage_class               = "STANDARD"
}

output "azurerm_storage_account_primary_endpoint" {
  value = azurerm_storage_account.example.primary_endpoint
}

output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.example.arn
}

output "google_storage_bucket_url" {
  value = google_storage_bucket.example.url
}
