# modules/project_services/main.tf

locals {
  core_apis = [
    # must come first
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
  ]

  other_apis = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    # optional:
    # "dns.googleapis.com",
    # "artifactregistry.googleapis.com",
  ]
}

# 1) Enable core APIs first
resource "google_project_service" "core" {
  for_each = toset(local.core_apis)

  project = var.project_id
  service = each.key

  disable_dependent_services = false

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

  disable_dependent_services = false

  # ensure core is fully on before proceeding
  depends_on = [google_project_service.core]

  timeouts {
    create = "20m"
    update = "20m"
  }
}
