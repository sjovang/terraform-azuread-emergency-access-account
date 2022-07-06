# Emergency Access Account

Implement an [Emergency cccess account](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

This account should also be exempt from conditional access policies that enforce MFA, logins should be monitored, and validated regularly.

**Note:**
Set `azure_ad_p2 == true` if your tenant has Azure AD P2-licenses to enable alerts from sign-in logs

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
| [azurerm_log_analytics_workspace.azure_ad_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_aad_diagnostic_setting.signin_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_monitor_action_group.security_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.breakglass_signin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_domains.initial](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) | data source |
| [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_ad_p2"></a> [azure\_ad\_p2](#input\_azure\_ad\_p2) | Set to true if tenant has Azure AD P2-licenses to enable sign-in alerts | `bool` | `false` | no |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Region in Azure | `string` | `"westeurope"` | no |
| <a name="input_log_analytics_resource_group_name"></a> [log\_analytics\_resource\_group\_name](#input\_log\_analytics\_resource\_group\_name) | Name of the resource group for the log analytics workspace | `string` | `"RG-AzureAD-Diagnostics"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of the log analytics workspace | `string` | `"LA-AzureAD-Diagnostics"` | no |
| <a name="input_log_analytics_workspace_retention_in_days"></a> [log\_analytics\_workspace\_retention\_in\_days](#input\_log\_analytics\_workspace\_retention\_in\_days) | Workspace retention in days | `number` | `30` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the breakglass account | `string` | n/a | yes |
| <a name="input_security_email_alerts"></a> [security\_email\_alerts](#input\_security\_email\_alerts) | Email address to send security alerts when Emergency access account is used | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for the breakglass account | `string` | `"breakglass"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->