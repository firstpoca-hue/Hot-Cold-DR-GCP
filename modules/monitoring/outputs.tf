output "alert_policy_id" {
  value       = google_monitoring_alert_policy.cpu_alert.id
  description = "ID of the alert policy"
}

output "uptime_check_id" { 
value = google_monitoring_uptime_check_config.http.id 
}
