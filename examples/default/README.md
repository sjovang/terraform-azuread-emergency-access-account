<!-- BEGIN_TF_DOCS -->
# Emergency access account-example

Minimal example that only provisions the account in Azure AD, assign Global Administrator-role and Owner-role on root management group

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
  features {}
}

module "emergency_access" {
  source = "sjovang/emergency-access-account/azuread"
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (~> 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.0)

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_emergency_access"></a> [emergency\_access](#module\_emergency\_access)

Source: sjovang/emergency-access-account/azuread

Version:
<!-- END_TF_DOCS -->