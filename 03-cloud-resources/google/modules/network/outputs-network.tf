output "vpc_id" {
  description = "VPC id."
  value       = google_compute_network.this.id
}

output "vpc_name" {
  description = "VPC name."
  value       = google_compute_network.this.name
}

output "vpc_self_link" {
  description = "VPC self link."
  value       = google_compute_network.this.self_link
}

output "subnets_self_link" {
  description = "Subnets self link"
  value       = { for k, v in google_compute_subnetwork.this : k => v.self_link }
}