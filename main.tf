terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

data "azuread_domains" "initial" {
  only_initial = true
}

data "azurerm_client_config" "core" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_client_config.core.tenant_id
}

resource "random_password" "emergency_user_password" {
  length = 64
}

resource "azuread_user" "emergency_access_account" {
  user_principal_name         = "${var.emergency_access_username}@${data.azuread_domains.initial.domains.0.domain_name}"
  display_name                = var.emergency_access_display_name
  disable_password_expiration = true
  password                    = random_password.emergency_access_account.result
}

resource "azuread_directory_role_assignment" "global_administrator" {
  role_id             = "62e90394-69f5-4237-9190-012177145e10"
  principal_object_id = resource.azuread_user.breakglass.object_id
}

resource "azurerm_role_assignment" "owner" {
  scope                = data.azurerm_management_group.root.id
  role_definition_name = "Owner"
  principal_id         = resource.azuread_user.breakglass.object_id
}

resource "azurerm_monitor_scheduled_query_rules_alert" "emergency_account_signin" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = "EmergencyAccount-Signin"
  description         = "Alert when emergency access account is used for sign-ins"
  location            = var.log_analytics_workspace.location
  resource_group_name = var.log_analytics_workspace.resource_group_name

  data_source_id = var.log_analytics_workspace.id

  # This should probably use a for_each and enable multiple action groups to receive alerts
  action {
    action_group  = azurerm_monitor_action_group.security_alerts.*.id
    email_subject = "Sign-in from Emergency access account detected"
  }

  query = format(<<-QUERY
        SigninLogs
        | project UserPrincipalName
        | where UserPrincipalName == "%s"
  QUERY
  , azuread_user.emergency_access_account.user_principal_name)
  severity    = 1
  frequency   = 5
  time_window = 30
  throttling  = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_action_group" "email_alerts" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = "Security-Alerts"
  resource_group_name = var.log_analytics_workspace.resource_group_name
  short_name          = "secalerts"

  email_receiver {
    name          = "Security-Mail-Alerts"
    email_address = var.security_email_alerts
  }
}