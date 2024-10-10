provider "azurerm" {
    resource_provider_registrations = "core"
    subscription_id = var.test_subscription_id
    features {
        key_vault {
            purge_soft_delete_on_destroy    = true
            recover_soft_deleted_key_vaults = false
        }
        log_analytics_workspace {
            permanently_delete_on_destroy = true
        }
    }
}

variable "test_subscription_id" {
    type = string
}

module "naming" {
    source = "Azure/naming/azurerm"
    version = "~> 0.4"
    suffix = [
        "test"
    ]
}

resource "azurerm_resource_group" "test" {
    name = module.naming.resource_group.name_unique
    location = "West Europe"
}

resource "azurerm_log_analytics_workspace" "test" {
    name = module.naming.log_analytics_workspace.name_unique
    location = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
    retention_in_days = 30
}

resource "azurerm_monitor_aad_diagnostic_setting" "test_signin_logs" {
    name = "SigninLogs"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id

    enabled_log {
      category = "SigninLogs"
      retention_policy {
        enabled = false
      }
    }
}

module "emergency_access_accounts" {
    source = "../"

    log_analytics_workspace = azurerm_log_analytics_workspace.test
    number_of_emergency_access_accounts = 1
    username_prefix = "test"

    alert_settings = {
        email_receivers = [
            "trond.sjovang@atea.no"
        ]
        sms_receivers = [
            {
                country_code = 47
                phone_number = 97036089
            }
        ]
    }

    tags = {
        description = "Deployed by running terraform test"
    }
}