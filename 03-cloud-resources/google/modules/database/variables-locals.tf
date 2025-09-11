locals {
  tags = merge(
    {
      owner = "${var.owner}"
  }, var.additional_tags)
}