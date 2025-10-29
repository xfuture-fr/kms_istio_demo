output "project_id"      { value = var.project_id }
output "region"          { value = var.region }
output "cluster_name"    { value = google_container_cluster.gke_autopilot.name }
output "artifact_repo"   {
  value = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker.repository_id}"
}
output "get_credentials_hint" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.gke_autopilot.name} --region ${var.region} --project ${var.project_id}"
}
