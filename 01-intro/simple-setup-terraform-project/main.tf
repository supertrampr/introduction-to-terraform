#region Initialization terraform
terraform {
  required_version = ">= 0.12.6"

  required_providers {}

  backend "local" {}
}
#endregion