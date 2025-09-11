resource "google_sql_user" "default" {
  instance = google_sql_database_instance.this.name
  name     = var.username
  password = var.default_user_password
  type     = "BUILT_IN"
}