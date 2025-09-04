#region resources

## Questo blocco di risorsa usa implicitamente il provider local se non specificato
## 
resource "local_file" "this" {
  count = var.create_file ? 3 : 0

  ## Enclosing a variable between ${} is useful 
  ## when you want to use a variable inside an argument value
  filename = "${path.root}/files/test-${var.courses[count.index]}.txt"
  content  = "Questa è la prima lezione di ${var.courses[count.index]}!"
}
#endregion