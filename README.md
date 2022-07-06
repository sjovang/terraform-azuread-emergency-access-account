# Emergency Access Account

Implement an [Emergency cccess account](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

This account should also be exempt from conditional access policies that enforce MFA, logins should be monitored, and validated regularly

## Module Overview

<!-- BEGIN_TF_DOC -->

<!-- END_TF_DOC -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role_assignment.global_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_user.breakglass](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_domains.initial](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) | data source |
| [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password"></a> [password](#input\_password) | Password for the breakglass account | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for the breakglass account | `string` | `"breakglass"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->