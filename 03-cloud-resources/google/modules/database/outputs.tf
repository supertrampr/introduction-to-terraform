output "sql_host" {
  description = "Database host of Google Cloud SQL."
  value       = google_sql_database_instance.this.first_ip_address
}

output "sql_user_name" {
  description = "Username of SQL user"
  value       = google_sql_user.default.name
}