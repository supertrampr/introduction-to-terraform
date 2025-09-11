resource "google_compute_address" "this" {
  name         = "pip-vm-${var.owner}"
  address_type = "EXTERNAL"
  labels       = local.tags
}