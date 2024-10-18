output "emergency_access_account" {
  value = {
    for k, u in azuread_user.emergency_access_account : k => {
      user_principal_name = u.user_principal_name
      password = u.password
    }
  }
  description = "Username and password for Emergency access account"
  sensitive = true
}