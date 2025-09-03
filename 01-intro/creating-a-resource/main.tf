#region Initialization terraform
terraform {
  required_version = ">= 0.12.6"

  required_providers {}

  backend "local" {}
}
#endregion

#region resources

## Questo blocco di risorsa usa implicitamente il provider local se non specificato
## 
resource "local_file" "this" {
  filename = "test.txt"
  content  = "Questa è la prima lezione di Terraform!"
}
#endregion