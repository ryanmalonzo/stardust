# Common

variable "docker_appdata" {
  type    = string
  default = "/opt/appdata"
}

variable "timezone" {
  type    = string
  default = "Europe/Paris"
}

variable "puid" {
  type    = string
  default = "1000"
}

variable "pgid" {
  type    = string
  default = "1000"
}

variable "nfs_media" {
  type    = string
  default = "/mnt/media"
}

variable "nfs_photos" {
  type    = string
  default = "/mnt/photos"
}

# Jellyfin

variable "incomplete_downloads_dir" {
  type    = string
  default = "/opt/incomplete-downloads"
}

variable "downloads_dir" {
  type    = string
  default = "/opt/downloads"
}

# Immich

variable "immich_db_password" {
  type      = string
  sensitive = true
}
