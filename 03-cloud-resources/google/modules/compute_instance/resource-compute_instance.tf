resource "google_compute_instance" "this" {
  name         = "vm-${lower(var.owner)}"
  machine_type = var.machine_type
  zone         = local.zone

  boot_disk {
    auto_delete = true
    device_name = "os-disk-vm-${var.owner}"

    initialize_params {
      size  = var.os_disk_size_gb
      type  = var.os_disk_type
      image = var.os_image # ubuntu-2204-jammy-v20250826
    }
  }

  network_interface {
    network    = try(length(var.subnetwork_self_link), 0) == 0 ? var.vpc_self_link : null
    subnetwork = try(length(var.vpc_self_link), 0) == 0 ? var.subnetwork_self_link : null
    network_ip = var.network_ip

    access_config {
      nat_ip = google_compute_address.this.address
    }
  }

  metadata = {
    "ssh-keys" = "${var.username}:${tls_private_key.this.public_key_openssh} ${var.username}"
  }

  labels = local.tags
}