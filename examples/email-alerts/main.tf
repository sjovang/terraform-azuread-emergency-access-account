terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "RSG-Log-Analytics"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "Azure-AD-Diagnostics"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_monitor_aad_diagnostic_setting" "signin_logs" {
  name                       = "SigninLogs"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  log {
    category = "SignInLogs"
    retention_policy {
      enabled = true
      days    = 30
    }
  }
}

module "emergency_access" {
  #source   = "sjovang/emergency-access-account/azuread"
  source                  = "../../"
  enable_alerts           = true
  email_alerts_address    = "soc@contoso.com"
  log_analytics_workspace = azurerm_log_analytics_workspace.example
}