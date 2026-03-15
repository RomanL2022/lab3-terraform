terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "lab1-487820"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}