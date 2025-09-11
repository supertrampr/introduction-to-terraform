locals {
  zone = data.google_compute_zones.available.names[random_integer.this.result]

  tags = merge(
    {
      owner = "${var.owner}"
  }, var.additional_tags)
}

resource "random_integer" "this" {
  min = 0
  max = length(data.google_compute_zones.available) - 1
}