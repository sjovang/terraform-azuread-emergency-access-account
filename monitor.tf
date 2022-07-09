/* resource "azurerm_resource_group" "log_analytics" {
  count    = var.enable_alerts == true ? 1 : 0
  name     = var.log_analytics_resource_group_name
  location = var.azure_location
}

resource "azurerm_log_analytics_workspace" "azure_ad_diagnostics" {
  count               = var.enable_alerts == true ? 1 : 0
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.log_analytics[0].location
  resource_group_name = azurerm_resource_group.log_analytics[0].name
  retention_in_days   = var.log_analytics_workspace_retention_in_days
}

resource "azurerm_monitor_aad_diagnostic_setting" "signin_logs" {
  count                      = var.enable_alerts == true ? 1 : 0
  name                       = "SigninLogs"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azure_ad_diagnostics[0].id

  log {
    category = "SignInLogs"
    retention_policy {
      enabled = true
      days    = 30
    }
  }
} */