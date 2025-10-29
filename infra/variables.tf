variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region (e.g., europe-west1)"
  type        = string
  default     = "europe-west9"
}

variable "network_name" {
  type    = string
  default = "vpc-mesh-demo"
}

variable "subnet_name" {
  type    = string
  default = "subnet-mesh-demo-ew1"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/20"
}

variable "pods_cidr" {
  type    = string
  default = "10.20.0.0/14"
}

variable "services_cidr" {
  type    = string
  default = "10.30.0.0/20"
}

variable "artifact_location" {
  description = "Artifact Registry location (multi-region 'europe' or a region)"
  type        = string
  default     = "europe"
}
