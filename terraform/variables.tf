variable "proxmox_endpoint_url" {
  type = string
}

variable "proxmox_node_name" {
  type    = string
  default = "pve"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}
