variable "alerts_evaluation_frequency" {
  type        = string
  default     = "PT5M"
  description = "How often the scheduled query rule is evaluated, represented in ISO 8601 duration format"
}

variable "alert_settings" {
  type = object({
    use_common_alert_schema = optional(bool, true)
    email_receivers         = optional(list(string), [])
    sms_receivers = optional(list(object({
      country_code = number
      phone_number = number
    })))
  })
  default     = {}
  description = "Configure settings for emergency access account sign in alerts"
}

variable "alerts_window_duration" {
  type        = string
  default     = "PT5M"
  description = "Specifies the period of time in ISO 8601 duration format on which the Scheduled Query Rule will be executed (bin size)"
}

variable "authentication_strength_policy_combinations" {
  type = list(string)
  default = [
    "fido2",
    "password",
    "temporaryAccessPassOneTime"
  ]
  description = "value"
}

variable "conditional_access_policy_id" {
  type = number
  default = 99
  description = "ID used to generate conditional access policy. Will create a name on the following format: CA<ID>-Emergency-access-accounts"
}

variable "conditional_access_policy_state" {
  type = string
  default = "enabled"
  description = "Set the enforcement mode for the conditional access policy"

  validation {
    condition = can(regex("^(enabled|disabled|enabledForReportingButNotEnforced)$", var.conditional_access_policy_state))
    error_message = "Allowed values: enabled, disabled, enabledForReportingButNotEnforced"
  }
}

variable "log_analytics_workspace" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
  })
  default = {
    id                  = null
    name                = null
    resource_group_name = null
    location            = null
  }
  description = "Log Analytics Workspace set up to stream EntraID sign-in logs"
}

variable "number_of_emergency_access_accounts" {
  type        = number
  default     = 2
  description = "Define how many accounts to create"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Add tags to all supported resources"
}

variable "username_prefix" {
  type        = string
  default     = ""
  description = "Add an optional prefix for the generated display name and user principal name"
}