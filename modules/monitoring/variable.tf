variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "workspace_display_name" {
  type        = string
  description = "Name of the monitoring workspace"
  default     = "gcp-monitoring-workspace"
}

variable "alert_policy_name" {
  type        = string
  description = "Name of the alerting policy"
  default     = "high-cpu-alert"
}

variable "metric_threshold" {
  type        = number
  description = "CPU utilization threshold for alerting"
  default     = 80
}


variable "primary_lb_host"     { 
type = string 
} # hostname to probe
variable "alert_channel_email" {
type = string 
}
variable "run_job_name"        {
 type = string 
 }
variable "run_job_region"      {
type = string 
}

