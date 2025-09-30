locals {
  core_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]

  other_apis = [
    "servicenetworking.googleapis.com",
    "dns.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
}

resource "google_project_service" "services" {
  for_each = toset([
    # ✅ Core services
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",

    # ✅ Other required services
    "servicenetworking.googleapis.com",
    "monitoring.googleapis.com",

    # ❌ EXCLUDED: "logging.googleapis.com"
    # ❌ DO NOT disable: "serviceusage.googleapis.com" (essential for project operations)
  ])

  project                     = var.project_id
  service                     = each.key
  disable_dependent_services = false
  disable_on_destroy          = false

  # lifecycle {
  #   prevent_destroy = true
  # }
}
