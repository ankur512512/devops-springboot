# GKE Cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.subnet_name

  node_locations = var.node_locations

  maintenance_policy {
    daily_maintenance_window {
      start_time = "00:00"
    }
  }
}

# Default Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "default-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_default_num_nodes

  node_config {
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    labels = {
      env = var.project_id
    }

    machine_type = var.node_machine_type
    tags         = ["gke-default-node", "${var.project_id}-gke"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Spot VM Node Pool
resource "google_container_node_pool" "primary_nodes_spotvms" {
  name     = "spot-node-pool"
  location = var.region
  cluster  = google_container_cluster.primary.name

  autoscaling {
    min_node_count = var.gke_spot_min_nodes
    max_node_count = var.gke_spot_max_nodes
  }

  node_config {
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    labels = {
      env = var.project_id
    }

    spot         = true
    machine_type = var.node_machine_type
    tags         = ["gke-spot-node", "${var.project_id}-gke"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
