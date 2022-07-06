variable "password" {
  type        = string
  sensitive   = true
  description = "Password for the breakglass account"
}

variable "username" {
  type        = string
  default     = "breakglass"
  description = "Username for the breakglass account"
}