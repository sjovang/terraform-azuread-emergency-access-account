<!-- BEGIN_TF_DOCS -->
# Emergency Access Accounts in Entra ID

Implement [Emergency access accounts](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (>= 2.44)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.20)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.0)

## Resources

The following resources are used by this module:

- [azuread_authentication_strength_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/authentication_strength_policy) (resource)
- [azuread_conditional_access_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy) (resource)
- [azuread_directory_role.global_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) (resource)
- [azuread_directory_role_assignment.global_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) (resource)
- [azuread_user.emergency_access_account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) (resource)
- [azurerm_monitor_action_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) (resource)
- [azurerm_monitor_scheduled_query_rules_alert_v2.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) (resource)
- [azurerm_resource_group.alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_role_assignment.owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [random_password.emergency_account_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [random_pet.emergency_account_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) (resource)
- [azuread_domains.initial](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) (data source)
- [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [azurerm_management_group.root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace)

Description: Log Analytics Workspace set up to stream EntraID sign-in logs

Type:

```hcl
object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_alert_settings"></a> [alert\_settings](#input\_alert\_settings)

Description: Configure settings for emergency access account sign in alerts

Type:

```hcl
object({
    use_common_alert_schema = optional(bool, true)
    email_receivers         = optional(list(string), [])
    sms_receivers = optional(list(object({
      country_code = number
      phone_number = number
    })))
  })
```

Default: `{}`

### <a name="input_alerts_evaluation_frequency"></a> [alerts\_evaluation\_frequency](#input\_alerts\_evaluation\_frequency)

Description: How often the scheduled query rule is evaluated, represented in ISO 8601 duration format

Type: `string`

Default: `"PT5M"`

### <a name="input_alerts_window_duration"></a> [alerts\_window\_duration](#input\_alerts\_window\_duration)

Description: Specifies the period of time in ISO 8601 duration format on which the Scheduled Query Rule will be executed (bin size)

Type: `string`

Default: `"PT5M"`

### <a name="input_authentication_strength_policy_combinations"></a> [authentication\_strength\_policy\_combinations](#input\_authentication\_strength\_policy\_combinations)

Description: Allowed combinations for authentication. temporary access pass are default for initial setup

Type: `list(string)`

Default:

```json
[
  "fido2",
  "temporaryAccessPassOneTime"
]
```

### <a name="input_conditional_access_policy_id"></a> [conditional\_access\_policy\_id](#input\_conditional\_access\_policy\_id)

Description: ID used to generate conditional access policy. Will create a name on the following format: CA<ID>-Emergency-access-accounts

Type: `number`

Default: `98`

### <a name="input_conditional_access_policy_state"></a> [conditional\_access\_policy\_state](#input\_conditional\_access\_policy\_state)

Description: Set the enforcement mode for the conditional access policy

Type: `string`

Default: `"enabled"`

### <a name="input_enable_alerts"></a> [enable\_alerts](#input\_enable\_alerts)

Description: Enable sign-in alerts

Type: `bool`

Default: `false`

### <a name="input_number_of_emergency_access_accounts"></a> [number\_of\_emergency\_access\_accounts](#input\_number\_of\_emergency\_access\_accounts)

Description: Define how many accounts to create

Type: `number`

Default: `2`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Add tags to all supported resources

Type: `map(string)`

Default: `{}`

### <a name="input_use_human_readable_passwords"></a> [use\_human\_readable\_passwords](#input\_use\_human\_readable\_passwords)

Description: The default behaviour is to generate a human readable password that is easy to print and store in a safe, set to false to generate complex passwords instead

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

## Modules

No modules.
<!-- END_TF_DOCS -->