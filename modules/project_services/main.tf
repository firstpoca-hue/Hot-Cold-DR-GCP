# modules/project_services/main.tf

locals {
  # Must be enabled first so other API operations succeed
  core_apis = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
  ]

  other_apis = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com",
    "dns.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}

# 1) Enable core APIs first
resource "google_project_service" "core" {
  for_each = toset(local.core_apis)

  project = var.project_id
  service = each.key

  # Do NOT cascade-disable anything and do NOT disable on destroy
  disable_dependent_services = false
  disable_on_destroy         = false

  timeouts {
    create = "20m"
    update = "20m"
  }
}

# 2) Then enable everything else
resource "google_project_service" "others" {
  for_each = toset(local.other_apis)

  project = var.project_id
  service = each.key

  # Do NOT cascade-disable anything and do NOT disable on destroy
  
  disable_dependent_services = false
  disable_on_destroy         = false

  # ensure core is fully on before proceeding
  depends_on = [google_project_service.core]

  timeouts {
    create = "20m"
    update = "20m"
  }
}

resource "google_project_service" "logging" {
  project                    = var.project_id
  service                    = "logging.googleapis.com"
  disable_on_destroy         = false
  # safety belt—prevents attempts to destroy
  lifecycle {
    prevent_destroy = true
  }
}
