#region resources

## Questo blocco di risorsa usa implicitamente il provider local se non specificato
## 
resource "local_file" "this" {
  for_each = var.courses

  ## Enclosing a variable between ${} is useful 
  ## when you want to use a variable inside an argument value
  filename = "${path.root}/files/test-${each.key}.txt"
  content  = "Questa è la prima ${each.value}"
}
#endregion