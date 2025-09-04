locals {
  resource_group_name = "introduction-to-terraform"
  tags = {
    "Owner" = "${var.owner}"
  }
}