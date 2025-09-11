resource "google_compute_network" "this" {
  name                    = "vpc-${var.owner}"
  description             = "Deployed by Terraform"
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "this" {
  for_each = var.subnetworks

  name          = "subnet-${var.owner}-${each.key}"
  description   = "Deployed by Terraform"
  network       = google_compute_network.this.id
  ip_cidr_range = each.value["ip_cidr_range"]

  lifecycle {
    precondition {
      condition     = var.auto_create_subnetworks == false && length(var.subnetworks) > 0
      error_message = "If auto_create_subnetworks is ${var.auto_create_subnetworks}, subnetworks must not be specified."
    }
  }
}