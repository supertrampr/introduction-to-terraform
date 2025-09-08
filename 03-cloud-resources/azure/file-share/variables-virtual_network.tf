variable "vnet_address_space" {
  description = "The address space that is used the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map containing subnet information."
  type        = map(list(string))
  default = {
    vm = [
      "192.168.1.0/25"
    ]
  }
}

variable "network_topology" {
  description = "Full topology network comprehending vnets and theirs subnets."
  type = map(object({
    vnet_address_space = list(string)
    subnets            = map(list(string))
  }))
}