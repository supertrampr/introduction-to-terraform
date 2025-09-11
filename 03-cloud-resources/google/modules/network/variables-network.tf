variable "auto_create_subnetworks" {
  description = "Is auto create subnetworks mode enabled?"
  type        = bool
  default     = false
}

variable "subnetworks" {
  description = "List of subnets information."
  type = map(object({
    ip_cidr_range = string
  }))
  default = {}
}