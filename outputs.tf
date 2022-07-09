output "emergency_user_account_password" {
  value       = random_password.emergency_access_account.result
  description = "Generated secure password for Emergeny access account"
}