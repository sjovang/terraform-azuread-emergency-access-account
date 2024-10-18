resource "azurerm_resource_group" "alerts" {
  name     = "rg-emergency-access-alerts"
  location = try(var.log_analytics_workspace.location, var.azure_monitor_location)
}

resource "azurerm_monitor_action_group" "this" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = "ag-emergency-access-alerts"
  resource_group_name = azurerm_resource_group.alerts.name
  short_name          = "eaa-signin"

  dynamic "email_receiver" {
    for_each = coalesce(try(var.alert_settings.email_receivers, null), [])
    content {
      name                    = "${email_receiver.value}-email"
      email_address           = email_receiver.value
      use_common_alert_schema = var.alert_settings.use_common_alert_schema
    }
  }

  dynamic "sms_receiver" {
    for_each = coalesce(try(var.alert_settings.sms_receivers, null), [])
    content {
      name         = sms_receiver.value.phone_number
      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = "EmergencyAccount-Signin"
  description         = "Alert when emergency access account is used for sign-ins"
  location            = azurerm_resource_group.alerts.location
  resource_group_name = azurerm_resource_group.alerts.name

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