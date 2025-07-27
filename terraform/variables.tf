variable "cloudflare_zone_id" {
  type    = string
  default = "a206782f5d00bb1d215aae2574638b1a"
}

variable "pangolin_ip" {
  type = string
}

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
