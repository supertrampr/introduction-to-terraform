terraform {
  backend "azurerm" {
    container_name       = "introduction-to-terraform"
    key                  = "raffaele/terraform-with-ci/terraform.tfstate"
    storage_account_name = "introductiontoterraform"
    metadata_host        = "management.azure.com"
  }
}