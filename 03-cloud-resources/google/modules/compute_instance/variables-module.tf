variable "owner" {
  description = "Owner of all resources."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to be added to resources."
  type        = map(string)
  default     = {}
}