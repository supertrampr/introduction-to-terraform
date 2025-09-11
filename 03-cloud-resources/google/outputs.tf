output "how_to_connect" {
  description = "Connection details for vm."
  value       = "ssh -i ${local_file.this.filename} ${module.vm.username}@${module.vm.public_ip}"
}

output "database_connection_string" {
  description = "Connection information about CLOUD SQL."
  value       = "mysql -h ${module.database.sql_host} -u ${module.database.sql_user_name} -p"
}