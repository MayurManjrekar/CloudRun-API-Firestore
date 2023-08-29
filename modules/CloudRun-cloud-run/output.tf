output "name" {
  description = "The backend service resources."
  value       = google_cloud_run_service.cloud-run.name
}

output "url" {
  description = "url of the cloud run" #backend cloud run url
  value       = "${google_cloud_run_service.cloud-run.status[0].url}"
}
