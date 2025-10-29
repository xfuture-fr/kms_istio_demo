resource "google_container_cluster" "gke_autopilot" {
  name     = "kms-istio-demo-autopilot"
  location = var.region

  enable_autopilot = true

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  release_channel { channel = "REGULAR" }

  # Enable Workload Identity (recommended for CI/CD & least privilege)
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  depends_on = [
    google_project_service.services,
    google_compute_subnetwork.subnet
  ]
}
