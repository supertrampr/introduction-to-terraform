resource "google_sql_database" "this" {
  for_each = var.databases

  name      = each.key
  charset   = strcontains(var.database_version, "POSTGRES") ? "UTF8" : each.value["charset"]
  collation = strcontains(var.database_version, "POSTGRES") ? "en_US.UTF8" : each.value["collation"]
  instance  = google_sql_database_instance.this.name
}