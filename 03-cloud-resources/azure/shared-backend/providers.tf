provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
  tenant_id                       = var.tenant_id

  features {}
}