# gke.tf
resource "google_container_cluster" "gke_standard" {
  name     = "kms-istio-demo-std"
  location = "europe-west9-a"          # <-- ZONE (pas la région)

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
  }

  release_channel { channel = "REGULAR" }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # IMPORTANT: ne mets PAS node_locations ici (sinon multi-zones)
}

resource "google_container_node_pool" "np1" {
  name     = "np1"
  cluster  = google_container_cluster.gke_standard.name
  location = "europe-west9-a"          # <-- ZONE identique

  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20                  # <-- petit disque
    disk_type    = "pd-standard"       # <-- évite le quota SSD_TOTAL_GB
    image_type   = "COS_CONTAINERD"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  management { 
    auto_upgrade = true
    auto_repair = true 
  }
}
