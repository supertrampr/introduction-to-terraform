variable "owner" {
  description = "Owner of all resources."
  type        = string
}

variable "location" {
  description = "Azure region where to deploy resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags for customization."
  type        = map(string)
  default     = {}
}