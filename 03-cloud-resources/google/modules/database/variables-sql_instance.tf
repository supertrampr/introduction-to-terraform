variable "database_version" {
  description = "Version and type of SQL instance."
  type        = string
  default     = "MYSQL_8_4"
}

variable "root_password" {
  description = "Root password"
  type        = string
  default     = null
}

variable "edition" {
  description = "Cloud SQL edition."
  type        = string
  default     = "ENTERPRISE"

  validation {
    condition     = var.edition == "ENTERPRISE" || var.edition == "ENTERPRISE_PLUS"
    error_message = "var.edition must be of value ENTERPRISE or ENTERPRISE_PLUS"
  }
}

variable "tier" {
  description = "Size of sql instance."
  type        = string
  default     = "db-f1-micro"
}

variable "availability_type" {
  description = "Availability type of the instance."
  type        = string
  default     = "ZONAL"
}

variable "disk_size" {
  description = "Disk size in GB."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Disk type."
  type        = string
  default     = "PD_SSD"
}

variable "database_flags" {
  description = "Map containing additional database flag."
  type        = map(string)
  default     = {}
}

variable "is_publicly_accesible" {
  description = "Will the SQL instance have a public ip assigned?"
  type        = bool
  default     = true
}

variable "authorized_networks" {
  description = "Authorized networks that will have access to the sql instance."
  type        = map(string)
  default     = {}
}

variable "binary_log_enabled" {
  description = "Is binary log enabled?"
  type        = bool
  default     = true
}

variable "is_backup_enabled" {
  description = "Enable backup."
  type        = bool
  default     = true
}

variable "vpc_self_link" {
  description = "VPC self link for private connection."
  type        = string
  default     = null
}