provider "google" {
  credentials = file("${path.module}/hot-cold-drp-d51a71d63867.json")
  project     = var.project_id
  region      = var.region_a
}
