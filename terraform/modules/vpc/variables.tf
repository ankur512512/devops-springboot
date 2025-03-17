variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR range"
  type        = string
  default     = "10.10.0.0/24"
}
