resource "google_sql_database_instance" "this" {
  name                = "${lower(split("_", var.database_version)[0])}-instance-${var.owner}"
  database_version    = var.database_version
  root_password       = try(random_password.this[0].result, null)
  deletion_protection = false


  settings {
    tier              = var.tier
    edition           = var.edition
    availability_type = var.availability_type
    disk_autoresize   = false
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    user_labels       = local.tags

    ip_configuration {
      ipv4_enabled    = var.is_publicly_accesible
      private_network = var.vpc_self_link

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        iterator = authorized_network

        content {
          name  = authorized_network.key
          value = authorized_network.value
        }
      }
    }

    backup_configuration {
      enabled            = var.is_backup_enabled
      binary_log_enabled = strcontains(var.database_version, "MYSQL") && var.is_backup_enabled ? var.binary_log_enabled : null
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      iterator = database_flag

      content {
        name  = database_flag.key
        value = database_flag.value
      }
    }
  }
}