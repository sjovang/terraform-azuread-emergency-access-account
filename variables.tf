variable "username_prefix" {
  type        = string
  default     = ""
  description = "Add an optional prefix for the generated display name and user principal name"
}

variable "number_of_emergency_access_accounts" {
  type        = number
  default     = 2
  description = "Define how many accounts to create"
}

variable "use_common_alert_schema" {
  type        = bool
  default     = true
  description = "Enable/Disable the common alert schema for all alerts"
}

variable "email_receiver" {
  type        = list(string)
  default     = []
  description = "List of mail addresses for triggered alerts"
}

variable "alerts_evaluation_frequency" {
  type        = string
  default     = "PT5M"
  description = "How often the scheduled query rule is evaluated, represented in ISO 8601 duration format"
}

variable "alerts_window_duration" {
  type        = string
  default     = "PT5M"
  description = "Specifies the period of time in ISO 8601 duration format on which the Scheduled Query Rule will be executed (bin size)"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Add tags to all supported resources"
}

// OLD variables are below

variable "enable_alerts" {
  type        = bool
  default     = false
  description = "Set up alerts for account sign-ins. Require Azure AD Premium-licenses"
}

variable "email_alerts_address" {
  type        = string
  default     = ""
  description = "Email address to send security alerts when emergency access account is used for sign-in"
}

variable "emergency_access_account_display_name" {
  type        = string
  default     = "Emergency access account"
  description = "Display name for emergency access account in Azure AD"
}

variable "emergency_access_account_password" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Password for emergency access account. If not specified a random password will be generated"
}

variable "emergency_access_account_username" {
  type        = string
  default     = "emergencyaccess"
  description = "Username for emergency access account. Only specify the username, not the full UserPrincipalName"
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
  description = "Log Analytics Workspace set up to stream Azure AD sign-in logs"
}

/* variable "log_analytics_resource_group_name" {
  type        = string
  default     = "RG-AzureAD-Diagnostics"
  description = "Name of the resource group for the log analytics workspace"
}

variable "log_analytics_workspace_name" {
  type        = string
  default     = "LA-AzureAD-Diagnostics"
  description = "Name of the log analytics workspace"
}

variable "log_analytics_workspace_retention_in_days" {
  type        = number
  default     = 30
  description = "Workspace retention in days"
} */