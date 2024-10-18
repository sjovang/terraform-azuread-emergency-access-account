resource "azuread_authentication_strength_policy" "this" {
  display_name         = "EmergencyAccess"
  description          = "Require phishing resistant MFA for emergency access accounts"
  allowed_combinations = var.authentication_strength_policy_combinations
}

resource "azuread_conditional_access_policy" "this" {
  display_name = format("CA%03s-%s", upper(var.conditional_access_policy_id), "Emergency-access-accounts")
  state        = var.conditional_access_policy_state

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = [
        for k, u in azuread_user.emergency_access_account : u.id
      ]
    }
  }

  grant_controls {
    authentication_strength_policy_id = azuread_authentication_strength_policy.this.id
    operator                          = "OR"
  }
}