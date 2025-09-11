variable "username" {
  description = "Default user name for SQL instance."
  type        = string
  default     = "adminuser"
}

variable "default_user_password" {
  description = "Default user password for authentication."
  type        = string
}