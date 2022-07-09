terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

module "breakglass" {
  source = "sjovang/emergency-access-account/azuread"
}