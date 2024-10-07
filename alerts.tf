resource "azurerm_monitor_action_group" "this" {
  count               = var.log_analytics_workspace != null ? 1 : 0
  name                = "ag-emergency-access-alerts"
  resource_group_name = var.log_analytics_workspace.resource_group_name
  short_name          = "eaa-signin"
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = "EmergencyAccount-Signin"
  description         = "Alert when emergency access account is used for sign-ins"
  location            = var.log_analytics_workspace.location
  resource_group_name = var.log_analytics_workspace.resource_group_name

  scopes = [
    var.log_analytics_workspace.id
  ]

  severity              = 1
  evaluation_frequency  = var.alerts_evaluation_frequency
  window_duration       = var.alerts_window_duration
  enabled               = true
  skip_query_validation = true

  action {
    action_groups = [
      azurerm_monitor_action_group.this[0].id
    ]
  }

  criteria {
    operator                = "GreaterThan"
    threshold               = 0
    time_aggregation_method = "Count"
    query                   = <<-QUERY
        SigninLogs
        | project UserPrincipalName
        | where UserPrincipalName contains "emergency-access"
    QUERY
  }

  tags = var.tags
}