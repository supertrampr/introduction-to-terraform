locals {
  resource_group_name  = "introduction-to-terraform"
  storage_account_name = replace(local.resource_group_name, "-", "")
  tags = {
    "Owner" = "${var.owner}"
  }
}