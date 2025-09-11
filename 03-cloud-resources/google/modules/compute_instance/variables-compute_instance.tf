variable "machine_type" {
  description = "Hardware specification of compute instance."
  type        = string
  default     = "e2-micro"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB."
  type        = number
  default     = 32
}

variable "os_disk_type" {
  description = "Type of OS disk."
  type        = string
  default     = "pd-standard"
}

variable "os_image" {
  description = "OS image of compute instance."
  type        = string
  default     = "ubuntu-2204-jammy-v20250826"
}

variable "subnetwork_self_link" {
  description = "Self link of subnetwork to connect to vm."
  type        = string
  default     = null
}

variable "vpc_self_link" {
  description = "Self link of network to connect to vm"
  type        = string
  default     = null
}

variable "network_ip" {
  description = "Specify a static private ip if any."
  type        = string
  default     = null
}

variable "username" {
  description = "Username of the virtual machine."
  type        = string
  default     = "adminuser"
}

