output "emergency_access_account_user_principal_name" {
  value       = {
    for k, u in azuread_user.emergency_access_account : k => u.user_principal_name
  }
  description = "User Principal name for emergency access account"
}

output "emergency_user_account_password" {
  value       = local.emergency_account_password
  description = "Generated password for Emergeny access account"
}