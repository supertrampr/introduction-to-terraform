#region variables
variable "courses" {
  description = "List of courses."
  type        = map(string)
  default     = {}
}

variable "create_file" {
  description = "Whether to create files or not."
  type        = bool
  default     = false
}
#endregion