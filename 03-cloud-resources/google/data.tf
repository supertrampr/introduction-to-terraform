data "terraform_remote_state" "azure" {
  backend = "azurerm"

  config = local.azurerm_backend_configuration
}