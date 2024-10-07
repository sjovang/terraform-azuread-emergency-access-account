terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0, != 2.26.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.20"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

data "azuread_domains" "initial" {
  only_initial = true
}

locals {
  emergency_access_accounts = toset([for u in range(1, var.number_of_emergency_access_accounts + 2) : format("%s-emergency-access-%02s", var.username_prefix, u)])
}

resource "random_password" "emergency_user_password" {
  for_each = local.emergency_access_accounts
  length   = 64
}

resource "azuread_user" "emergency_access_account" {
  for_each                    = local.emergency_access_accounts
  user_principal_name         = "${each.key}@${data.azuread_domains.initial.domains.0.domain_name}"
  display_name                = each.key
  disable_password_expiration = true
  password                    = random_password.emergency_user_password[each.key]
}

resource "azuread_directory_role" "global_administrator" {
  display_name = "Global Administrator"
}

resource "azuread_directory_role_assignment" "global_administrator" {
  for_each            = local.emergency_access_accounts
  role_id             = azuread_directory_role.global_administrator.template_id
  principal_object_id = resource.azuread_user.emergency_access_account[each.key].object_id
}

data "azurerm_client_config" "core" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_client_config.core.tenant_id
}

resource "azurerm_role_assignment" "owner" {
  for_each             = local.emergency_access_accounts
  scope                = data.azurerm_management_group.root.id
  role_definition_name = "Owner"
  principal_id         = resource.azuread_user.emergency_access_account[each.key].object_id
}