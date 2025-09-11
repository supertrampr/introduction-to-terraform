provider "google" {
  region      = var.google_region
  project     = var.google_project_id
  credentials = "${path.root}/credentials/google_credentials.json"
}