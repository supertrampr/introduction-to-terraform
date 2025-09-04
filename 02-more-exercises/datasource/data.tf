data "http" "this" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "The status code is not 200."
    }
  }
}