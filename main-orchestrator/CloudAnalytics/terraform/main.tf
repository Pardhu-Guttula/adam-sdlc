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
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  region = var.aws_region
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "exampleIdentity"
}

resource "aws_iam_role" "example" {
  name               = "exampleRole"
  assume_role_policy = "${data.aws_iam_policy_document.example.json}"
}

resource "aws_iam_policy_document" "example" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
