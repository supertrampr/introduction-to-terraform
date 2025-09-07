variable "enable_ssh_access" {
  description = "Whether to enable ssh access on the vm or not."
  type        = bool
  default     = true
}

variable "admin_username" {
  description = "Admin username."
  type        = string
  default     = "adminuser"
}

variable "additional_nic_ids" {
  description = "Additional Network Interface IDs if any."
  type        = list(string)
  default     = []
}

variable "nic_ip_config" {
  description = "Information about network interface configuration."
  type = map(object({
    is_primary    = optional(bool, false)
    ip_allocation = optional(string, "Dynamic")
    ip_address    = optional(string)
  }))
}