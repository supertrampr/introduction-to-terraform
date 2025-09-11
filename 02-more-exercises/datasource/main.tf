#region resources

## Questo blocco di risorsa usa implicitamente il provider local se non specificato
## 
resource "local_file" "response" {
  ## Enclosing a variable between ${} is useful 
  ## when you want to use a variable inside an argument value
  filename = "${path.root}/files/response_body.json"
  content  = data.http.this.response_body

  lifecycle {
    precondition {
      condition     = data.http.this.status_code == 200
      error_message = "The status code is not 200."
    }
  }
}

resource "random_string" "this" {
  length = 12
}

resource "local_file" "result" {
  ## Enclosing a variable between ${} is useful 
  ## when you want to use a variable inside an argument value
  filename = "${path.root}/files/result-${random_string.this.result}.txt"
  content = templatefile("${path.root}/result.txt.tftpl", {
    product          = jsondecode(data.http.this.response_body)["product"]
    version          = jsondecode(data.http.this.response_body)["current_version"]
    response_headers = data.http.this.response_headers
  })

  lifecycle {
    # ignore_changes = [ 
    #   content
    # ]
    prevent_destroy       = false
    create_before_destroy = false
  }
}
#endregion