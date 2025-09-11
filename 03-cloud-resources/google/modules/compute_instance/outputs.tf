output "public_ip" {
  description = "Public ip associated to vm."
  value       = google_compute_address.this.address
}

output "ssh_private_key" {
  description = "SSH key private value."
  value       = tls_private_key.this.private_key_openssh
}

output "username" {
  description = "Username to connect to vm."
  value       = var.username
}