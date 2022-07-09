variable "azure_location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure"
}

variable "enable_alerts" {
  type        = bool
  default     = false
  description = "Set up alerts for account sign-ins. Require Azure AD Premium-licenses"
}

variable "email_alerts_addresss" {
  type        = string
  default     = ""
  description = "Email address to send security alerts when emergency access account is used for sign-in"
}

variable "emergency_access_username" {
  type        = string
  default     = "breakglass"
  description = "Username for the emergency access account. Only specify the username, not the full UserPrincipalName"
}

variable "emergency_access_display_name" {
  type     = string
  default  = "Emergency access account"
  description = "Display name for emergency access account in Azure AD"
}

variable "log_analytics_workspace" {
  type = map(object)
  default = ""
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