terraform {
  required_version = ">= 0.12.6"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.3"
    }
  }
}