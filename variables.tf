variable "azure_location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure"
}

variable "azure_ad_p2" {
  type        = bool
  default     = false
  description = "Set to true if tenant has Azure AD P2-licenses to enable sign-in alerts"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "Password for the breakglass account"
}

variable "username" {
  type        = string
  default     = "breakglass"
  description = "Username for the breakglass account"
}

variable "log_analytics_resource_group_name" {
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
}

variable "security_email_alerts" {
  type    = string
  description = "Email address to send security alerts when Emergency access account is used"
}