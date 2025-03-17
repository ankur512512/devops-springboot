# Deploy VPC Module
module "vpc" {
  source      = "./modules/vpc"
  project_id  = var.project_id
  region      = var.region
  subnet_cidr = "10.10.0.0/24"
}

# Deploy GKE Module
module "gke" {
  source                = "./modules/gke"
  project_id            = var.project_id
  region                = var.region
  vpc_name              = module.vpc.vpc_name
  subnet_name           = module.vpc.subnet_name
  gke_default_num_nodes = 2
  gke_spot_min_nodes    = 2
  gke_spot_max_nodes    = 4
  node_machine_type     = "n2d-standard-2"
  node_locations        = ["europe-west3-a", "europe-west3-b"]
}
