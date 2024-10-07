<!-- BEGIN_TF_DOCS -->
# Emergency Access Accounts in Entra ID

Implement [Emergency access accounts](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (>= 2.0, != 2.26.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.0)

## Resources

The following resources are used by this module:

- [azuread_directory_role_assignment.global_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) (resource)
- [azuread_user.emergency_access_account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) (resource)
- [azurerm_monitor_action_group.email_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) (resource)
- [azurerm_monitor_scheduled_query_rules_alert.emergency_account_signin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) (resource)
- [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [random_password.emergency_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [azuread_domains.initial](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) (data source)
- [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_alerts_evaluation_frequency"></a> [alerts\_evaluation\_frequency](#input\_alerts\_evaluation\_frequency)

Description: How often the scheduled query rule is evaluated, represented in ISO 8601 duration format

Type: `string`

Default: `"PT5M"`

### <a name="input_alerts_window_duration"></a> [alerts\_window\_duration](#input\_alerts\_window\_duration)

Description: Specifies the period of time in ISO 8601 duration format on which the Scheduled Query Rule will be executed (bin size)

Type: `string`

Default: `"PT5M"`

### <a name="input_email_alerts_address"></a> [email\_alerts\_address](#input\_email\_alerts\_address)

Description: Email address to send security alerts when emergency access account is used for sign-in

Type: `string`

Default: `""`

### <a name="input_email_receiver"></a> [email\_receiver](#input\_email\_receiver)

Description: List of mail addresses for triggered alerts

Type: `list(string)`

Default: `[]`

### <a name="input_emergency_access_account_display_name"></a> [emergency\_access\_account\_display\_name](#input\_emergency\_access\_account\_display\_name)

Description: Display name for emergency access account in Azure AD

Type: `string`

Default: `"Emergency access account"`

### <a name="input_emergency_access_account_password"></a> [emergency\_access\_account\_password](#input\_emergency\_access\_account\_password)

Description: Password for emergency access account. If not specified a random password will be generated

Type: `string`

Default: `""`

### <a name="input_emergency_access_account_username"></a> [emergency\_access\_account\_username](#input\_emergency\_access\_account\_username)

Description: Username for emergency access account. Only specify the username, not the full UserPrincipalName

Type: `string`

Default: `"emergencyaccess"`

### <a name="input_enable_alerts"></a> [enable\_alerts](#input\_enable\_alerts)

Description: Set up alerts for account sign-ins. Require Azure AD Premium-licenses

Type: `bool`

Default: `false`

### <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace)

Description: Log Analytics Workspace set up to stream Azure AD sign-in logs

Type:

```hcl
object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
  })
```

Default:

```json
{
  "id": null,
  "location": null,
  "name": null,
  "resource_group_name": null
}
```

### <a name="input_number_of_emergency_access_accounts"></a> [number\_of\_emergency\_access\_accounts](#input\_number\_of\_emergency\_access\_accounts)

Description: Define how many accounts to create

Type: `number`

Default: `2`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Add tags to all supported resources

Type: `map(any)`

Default: `{}`

### <a name="input_use_common_alert_schema"></a> [use\_common\_alert\_schema](#input\_use\_common\_alert\_schema)

Description: Enable/Disable the common alert schema for all alerts

Type: `bool`

Default: `true`

### <a name="input_username_prefix"></a> [username\_prefix](#input\_username\_prefix)

Description: Add an optional prefix for the generated display name and user principal name

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_emergency_access_account_user_principal_name"></a> [emergency\_access\_account\_user\_principal\_name](#output\_emergency\_access\_account\_user\_principal\_name)

Description: User Principal name for emergency access account

### <a name="output_emergency_user_account_password"></a> [emergency\_user\_account\_password](#output\_emergency\_user\_account\_password)

Description: Generated password for Emergeny access account

## Modules

No modules.
<!-- END_TF_DOCS -->