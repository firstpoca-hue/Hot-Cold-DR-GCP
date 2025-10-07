output "workspace_id" {
  value       = google_monitoring_workspace.workspace.id
  description = "ID of the monitoring workspace"
}

output "alert_policy_id" {
  value       = google_monitoring_alert_policy.cpu_alert.id
  description = "ID of the alert policy"
}
