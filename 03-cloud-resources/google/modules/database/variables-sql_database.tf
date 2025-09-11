variable "databases" {
  description = "Map of databases to create."
  type = map(object({
    charset   = optional(string)
    collation = optional(string)
  }))
  default = {}
}