variable "subnetworks" {
  description = "List of subnets information."
  type = map(object({
    ip_cidr_range = string
  }))
  default = {}
}