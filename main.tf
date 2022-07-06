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
  }
}

data "azuread_domains" "initial" {
  only_initial = true
}

data "azurerm_client_config" "core" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_client_config.core.tenant_id
}

resource "azuread_user" "breakglass" {
  user_principal_name         = "${var.username}@${data.azuread_domains.initial.domains.0.domain_name}"
  display_name                = "Breakglass Administrator Account"
  disable_password_expiration = true
  password                    = var.password
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