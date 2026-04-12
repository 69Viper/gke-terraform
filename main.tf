resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1
  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }
}


resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.region

  cluster    = google_container_cluster.primary.name

  node_count = 1

  node_config {
    machine_type = "e2-micro"
    disk_size_gb = 30
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}