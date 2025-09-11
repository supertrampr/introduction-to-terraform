terraform {
  backend "gcs" {
    bucket      = "introductiontoterraform"
    prefix      = "raffaele"
    credentials = "./credentials/google_credentials.json"
  }
}