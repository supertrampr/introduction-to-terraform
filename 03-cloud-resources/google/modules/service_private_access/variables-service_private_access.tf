variable "global_address_name" {
  description = "Global address name."
  type        = string
}

variable "prefix_length" {
  description = "Address range prefix."
  type        = number
}

variable "vpc_id" {
  description = "VPC ID to connect to."
  type        = string
}
