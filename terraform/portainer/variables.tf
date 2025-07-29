variable "docker_appdata" {
  type    = string
  default = "/opt/appdata"
}

variable "puid" {
  type    = string
  default = "1000"
}

variable "pgid" {
  type    = string
  default = "1000"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}

variable "zfs_media" {
  type    = string
  default = "/mnt/media"
}
