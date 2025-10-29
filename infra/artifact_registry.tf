resource "google_artifact_registry_repository" "docker" {
  location      = var.artifact_location   # e.g., "europe"
  repository_id = "docker"
  description   = "Docker images for demo microservices"
  format        = "DOCKER"
  depends_on    = [google_project_service.services]
}
