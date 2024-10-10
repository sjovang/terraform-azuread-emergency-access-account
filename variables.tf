variable "alerts_evaluation_frequency" {
  type        = string
  default     = "PT5M"
  description = "How often the scheduled query rule is evaluated, represented in ISO 8601 duration format"
}

variable "alerts_settings" {
  type = object({
    use_common_alert_schema = optional(bool,true)
    email_receiver = optional(list(string), [])
    sms_receiver = optional(list(object({
      country_code = number
      phone_number = number
    })))
  })
  default = {}
  description = "Configure settings for emergency access account sign in alerts"
}

variable "alerts_window_duration" {
  type        = string
  default     = "PT5M"
  description = "Specifies the period of time in ISO 8601 duration format on which the Scheduled Query Rule will be executed (bin size)"
}

variable "email_receiver" {
  type        = list(string)
  default     = []
  description = "List of mail addresses for triggered alerts"
}

variable "log_analytics_workspace" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
  })
  nullable = true
  description = "Log Analytics Workspace set up to stream EntraID sign-in logs"
}

variable "number_of_emergency_access_accounts" {
  type        = number
  default     = 2
  description = "Define how many accounts to create"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Add tags to all supported resources"
}

variable "username_prefix" {
  type        = string
  default     = ""
  description = "Add an optional prefix for the generated display name and user principal name"
}