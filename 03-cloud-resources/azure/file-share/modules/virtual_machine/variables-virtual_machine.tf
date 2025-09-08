variable "enable_ssh_access" {
  description = "Whether to enable ssh access on the vm or not."
  type        = bool
}

variable "size" {
  description = "VM size to be deployed."
  type        = string
}

variable "custom_data" {
  description = "Custom data for VM boot."
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "Admin username."
  type        = string
  default     = "adminuser"
}

variable "os_image" {
  description = "OS image information."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "os_disk" {
  description = "OS disk information."
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
    name                 = optional(string)
  })
  default = {
    caching              = "None"
    disk_size_gb         = 32
    storage_account_type = "Standard_LRS"
  }
}

