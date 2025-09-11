resource "random_password" "this" {
  count = strcontains(var.database_version, "SQLSERVER") ? 1 : 0

  length           = 12
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!_."
}