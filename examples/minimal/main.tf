terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0, <= 2.25.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

module "emergency_access" {
  source = "sjovang/emergency-access-account/azuread"
}