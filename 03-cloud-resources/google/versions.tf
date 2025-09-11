terraform {
  required_version = ">= 0.12.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.1.1"
    }
  }
}