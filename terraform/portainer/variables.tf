variable "docker_appdata" {
  type    = string
  default = "/opt/appdata"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}

variable "zfs_media" {
  type    = string
  default = "/mnt/media"
}
