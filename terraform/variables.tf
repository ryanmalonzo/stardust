variable "proxmox_endpoint_url" {
  type = string
}

variable "proxmox_node_name" {
  type    = string
  default = "pve"
}

variable "scaleway_project_id" {
  type    = string
  default = "e33dacaf-8af1-4c05-a122-83cb74b74298"
}

variable "scaleway_region" {
  type    = string
  default = "fr-par"
}

variable "scaleway_zone" {
  type    = string
  default = "fr-par-1"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}
