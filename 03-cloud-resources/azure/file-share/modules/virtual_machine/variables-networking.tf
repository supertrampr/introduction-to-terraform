variable "network_security_rules" {
  description = "List of network security rules."
  type = map(object({
    access                  = string
    direction               = string
    priority                = number
    protocol                = string
    source_port_range       = string
    destination_port_ranges = list(string)
    source_address_prefixes = list(string)
  }))
}

variable "nic_ip_config" {
  description = "Information about network interface configuration."
  type = map(object({
    is_primary    = optional(bool, false)
    ip_allocation = optional(string, "Dynamic")
    ip_address    = optional(string)
  }))
}

variable "subnet_id" {
  description = "Subnet ID."
  type        = string
}

variable "additional_nic_ids" {
  description = "Additional Network Interface IDs if any."
  type        = list(string)
  default     = []
}

variable "public_ip_allocation_method" {
  description = "Method to allocate the public ip."
  type        = string
  default     = "Static"

  validation {
    condition = (var.public_ip_allocation_method == "Static" ||
    var.public_ip_allocation_method == "Dynamic")
    error_message = "Allowed values are: Static or Dynamic"
  }
}

variable "is_vm_public" {
  description = "Whether the vm is publicly accessible."
  type        = bool
  default     = true
}