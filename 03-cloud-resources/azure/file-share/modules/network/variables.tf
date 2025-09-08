variable "vnet_address_space" {
  description = "The address space that is used the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map containing subnet information."
  type        = map(list(string))
}

variable "location" {
  description = "Location of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where to deploy our vnet."
  type        = string
}