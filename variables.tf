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