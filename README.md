# Emergency Access Account

Implement an [Emergency cccess account](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

This account should also be exempt from conditional access policies that enforce MFA, logins should be monitored, and validated regularly.

**Note:**
Set `enable_alerts == true` if your tenant has Azure AD P2-licenses to enable alerts from sign-in logs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.0, <= 2.25.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.0, <= 2.25.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role_assignment.global_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_user.emergency_access_account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [azurerm_monitor_action_group.email_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.emergency_account_signin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_password.emergency_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_domains.initial](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) | data source |
| [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_alerts_address"></a> [email\_alerts\_address](#input\_email\_alerts\_address) | Email address to send security alerts when emergency access account is used for sign-in | `string` | `""` | no |
| <a name="input_emergency_access_account_display_name"></a> [emergency\_access\_account\_display\_name](#input\_emergency\_access\_account\_display\_name) | Display name for emergency access account in Azure AD | `string` | `"Emergency access account"` | no |
| <a name="input_emergency_access_account_password"></a> [emergency\_access\_account\_password](#input\_emergency\_access\_account\_password) | Password for emergency access account. If not specified a random password will be generated | `string` | `""` | no |
| <a name="input_emergency_access_account_username"></a> [emergency\_access\_account\_username](#input\_emergency\_access\_account\_username) | Username for emergency access account. Only specify the username, not the full UserPrincipalName | `string` | `"emergencyaccess"` | no |
| <a name="input_enable_alerts"></a> [enable\_alerts](#input\_enable\_alerts) | Set up alerts for account sign-ins. Require Azure AD Premium-licenses | `bool` | `false` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | Log Analytics Workspace set up to stream Azure AD sign-in logs | <pre>object({<br>    id                  = string<br>    name                = string<br>    resource_group_name = string<br>    location            = string<br>  })</pre> | <pre>{<br>  "id": null,<br>  "location": null,<br>  "name": null,<br>  "resource_group_name": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_emergency_user_account_password"></a> [emergency\_user\_account\_password](#output\_emergency\_user\_account\_password) | Generated secure password for Emergeny access account |
<!-- END_TF_DOCS -->