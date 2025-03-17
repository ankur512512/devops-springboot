variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "gke_default_num_nodes" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "gke_spot_min_nodes" {
  description = "Minimum number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "gke_spot_max_nodes" {
  description = "Maximum number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "node_machine_type" {
  description = "Machine type for the nodes"
  type        = string
  default     = "n2d-standard-2"
}

variable "node_locations" {
  description = "List of zones where nodes will be created"
  type        = list(string)
  default     = ["europe-west3-a", "europe-west3-b"]
}
