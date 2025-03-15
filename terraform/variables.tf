### Variables definition

variable "project_id" {
  default     = ""
  description = "project id"
}

variable "region" {
  default     = ""
  description = "region"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke primary nodes"
}
