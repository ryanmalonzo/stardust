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

variable "nfs_media" {
  type    = string
  default = "/mnt/media"
}

variable "incomplete_downloads_dir" {
  type    = string
  default = "/opt/incomplete-downloads"
}

variable "downloads_dir" {
  type    = string
  default = "/opt/downloads"
}
