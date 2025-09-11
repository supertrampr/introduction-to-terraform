locals {
  backend_file_content = split("\n", file("../azure/shared-backend/backend/azurerm.hcl"))

  azurerm_backend_configuration = { for k, v in local.backend_file_content :
    "${trimspace(split("= ", v)[0])}" => "${replace(split("= ", v)[1], "\"", "")}"
  }
}