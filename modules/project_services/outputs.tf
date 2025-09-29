output "enabled_services" {
  description = "List of all services enabled by this module."
  value = concat(
    [for s in google_project_service.core   : s.service],
    [for s in google_project_service.others : s.service],
  )
}
