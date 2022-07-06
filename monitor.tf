resource "azurerm_resource_group" "log_analytics" {
  count    = var.azure_ad_p2 == true ? 1 : 0
  name     = var.log_analytics_resource_group_name
  location = var.azure_location
}

resource "azurerm_log_analytics_workspace" "azure_ad_diagnostics" {
  count               = var.azure_ad_p2 == true ? 1 : 0
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.log_analytics[0].location
  resource_group_name = azurerm_resource_group.log_analytics[0].name
  retention_in_days   = var.log_analytics_workspace_retention_in_days
}

resource "azurerm_monitor_aad_diagnostic_setting" "signin_logs" {
  count                      = var.azure_ad_p2 == true ? 1 : 0
  name                       = "SigninLogs"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azure_ad_diagnostics[0].id

  log {
    category = "SignInLogs"
    retention_policy {
        enabled = true
        days = 30
    }
  }
}

resource "azurerm_monitor_action_group" "security_alerts" {
  count               = var.azure_ad_p2 == true ? 1 : 0
  name                = "Security-Alerts"
  resource_group_name = azurerm_resource_group.log_analytics[0].name
  short_name          = "secalerts"

  email_receiver {
    name          = "Security-Mail-Alerts"
    email_address = var.security_email_alerts
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "breakglass_signin" {
  count               = var.azure_ad_p2 == true ? 1 : 0
  name                = "Breakglass-Signin"
  description         = "Alert when Breakglass account is used for sign-ins"
  location = azurerm_resource_group.log_analytics[0].location
  resource_group_name = azurerm_resource_group.log_analytics[0].name

  data_source_id  = azurerm_log_analytics_workspace.azure_ad_diagnostics[0].id

  action {
    action_group  = azurerm_monitor_action_group.security_alerts.*.id
    email_subject = "Sign-in from Emergency access account detected"
  }

  query = format(<<-QUERY
        SigninLogs
        | project UserPrincipalName
        | where UserPrincipalName == "%s"
  QUERY
  , azuread_user.breakglass.user_principal_name)
  severity    = 1
  frequency   = 5
  time_window = 30
  throttling  = 30
  trigger {
    operator = "GreaterThanOrEqual"
    threshold = 1
  }
}
