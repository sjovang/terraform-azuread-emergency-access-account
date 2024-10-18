<!-- BEGIN_TF_DOCS -->
# Emergency access account-example

Full example with alerts and everything

```hcl
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
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-emergency-access"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "la-example-emergency-access"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_aad_diagnostic_setting" "example" {
  name                       = "SigninLogs"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  enabled_log {
    category = "SignInLogs"
    retention_policy {
      enabled = false
    }
  }
}

module "emergency_access" {
  source                      = "../.."
  alerts_evaluation_frequency = "PT5M"
  alert_settings = {
    use_common_alert_schema = true
    email_receivers = [
      "<email@address.for.alerts"
    ]
    sms_receivers = [
      {
        country_code = "<country code, e.g. 47 for Norway>"
        phone_number = "<phone number>"
      }
    ]
  }
  alerts_window_duration = "PT5M"
  authentication_strength_policy_combinations = [
    "fido2",
    "temporaryAccessPassOneTime"
  ]
  conditional_access_policy_id        = 42
  conditional_access_policy_state     = "enabledForReportingButNotEnforced"
  enable_alerts                       = true
  log_analytics_workspace             = azurerm_log_analytics_workspace.example
  number_of_emergency_access_accounts = 2
  tags = {
    description          = "example"
    managed-by-terraform = true
  }
  username_prefix              = ""
}

# Example output from module. Can be used to save username and password in vaults or secrets managers
output "emergency_access_users" {
  value = {
    for k, u in module.emergency_access.emergency_access_account : k => {
      user_principal_name = u.user_principal_name
      password = u.password
    }
  }
  sensitive = true
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.0)

## Resources

The following resources are used by this module:

- [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) (resource)
- [azurerm_monitor_aad_diagnostic_setting.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) (resource)
- [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_emergency_access_users"></a> [emergency\_access\_users](#output\_emergency\_access\_users)

Description: Example output from module. Can be used to save username and password in vaults or secrets managers

## Modules

The following Modules are called:

### <a name="module_emergency_access"></a> [emergency\_access](#module\_emergency\_access)

Source: ../..

Version:
<!-- END_TF_DOCS -->