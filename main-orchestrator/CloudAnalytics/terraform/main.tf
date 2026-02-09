terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
    aws = {
      source = "hashicorp/aws"
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

resource "azurerm_role_definition" "example" {
  name                            = "ExampleRole"
  role_definition_id              = uuid()
  scope                           = "/subscriptions/${data.azurerm_subscription.primary.subscription_id}"
  permissions {
    actions   = ["*"]
    not_actions = []
  }
  assignable_scopes              = ["/subscriptions/${data.azurerm_subscription.primary.subscription_id}"]
}

resource "aws_iam_role" "example" {
  name = "example_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "azurerm_cost_management_export" "example" {
  name                = "example-export"
  resource_group_name = var.resource_group_name
  storage_account_id  = var.storage_account_id
  recurrence_period {
    from_date = "YYYY-MM-DD"
    to_date   = "YYYY-MM-DD"
    type      = "Monthly"
  }
  schedule {
    recurrence   = "Annually"
    recurrence_years = [var.recurrence_year]
  }
  format = "Csv"
}

resource "aws_ce_cost_category" "example" {
  name = "example"
  rules {
    type = "REGULAR"
    value = "Testing"
    rule_version = "Cost Category Expression V1"
  }
}

resource "azurerm_security_center" "example" {
  pricing {
    tier = "Free"
  }
}

resource "aws_securityhub_account" "example" {
  depends_on = [aws_iam_role.example]
}
