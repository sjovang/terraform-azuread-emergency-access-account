output "emergency_access_account_user_principal_name" {
  value       = azuread_user.emergency_access_account.user_principal_name
  description = "User Principal name for emergency access account"
}

output "emergency_user_account_password" {
  value       = random_password.emergency_user_password
  description = "Generated password for Emergeny access account"
}