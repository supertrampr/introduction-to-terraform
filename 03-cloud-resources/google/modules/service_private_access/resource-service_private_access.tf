resource "google_compute_global_address" "this" {
  name          = var.global_address_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.prefix_length
  network       = var.vpc_id
}

resource "google_service_networking_connection" "this" {
  network = var.vpc_id
  reserved_peering_ranges = [
    google_compute_global_address.this.name
  ]
  service                 = "servicenetworking.googleapis.com"
  update_on_creation_fail = true
}