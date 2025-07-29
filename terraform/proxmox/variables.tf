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

variable "gpu_pci_id" {
  type    = string
  default = "0000:00:02"
}
