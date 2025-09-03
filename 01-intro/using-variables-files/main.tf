#region Initialization terraform
terraform {
  required_version = ">= 0.12.6"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.3"
    }
  }

  backend "local" {}
}
#endregion

#region providers
provider "local" {

}
#endregion

#region variables
variable "course" {
  description = "Name of the course."
  type        = string
}
#endregion

#region resources

## Questo blocco di risorsa usa implicitamente il provider local se non specificato
## 
resource "local_file" "this" {
  ## Enclosing a variable between ${} is useful 
  ## when you want to use a variable inside an argument value
  filename = "test-${var.course}.txt"
  content  = "Questa è la prima lezione di ${var.course}!"
}
#endregion