
resource "portainer_environment" "local" {
  name                   = "local"
  environment_address    = "unix:///var/run/docker.sock"
  type                   = 1
  tls_enabled            = true
  tls_skip_client_verify = true
  tls_skip_verify        = true
}

module "backrest" {
  source      = "./modules/stack"
  name        = "backrest"
  yaml_file   = "${path.module}/docker/backrest.yaml"
  endpoint_id = portainer_environment.local.id
  env_vars = {
    DOCKER_BACKREST = "/opt/backrest"
    DOCKER_APPDATA  = var.docker_appdata
    TZ              = var.timezone
  }
}

module "vaultwarden" {
  source      = "./modules/stack"
  name        = "vaultwarden"
  yaml_file   = "${path.module}/docker/vaultwarden.yaml"
  endpoint_id = portainer_environment.local.id
  env_vars = {
    DOCKER_APPDATA = var.docker_appdata
  }
}

module "jellyfin" {
  source      = "./modules/stack"
  name        = "jellyfin"
  yaml_file   = "${path.module}/docker/jellyfin.yaml"
  endpoint_id = portainer_environment.local.id
  env_vars = {
    DOCKER_APPDATA           = var.docker_appdata
    NFS_MEDIA                = var.nfs_media
    TZ                       = var.timezone
    PUID                     = var.puid
    PGID                     = var.pgid
    INCOMPLETE_DOWNLOADS_DIR = var.incomplete_downloads_dir
    DOWNLOADS_DIR            = var.downloads_dir
  }
}

module "immich" {
  source      = "./modules/stack"
  name        = "immich"
  yaml_file   = "${path.module}/docker/immich.yaml"
  endpoint_id = portainer_environment.local.id
  env_vars = {
    DB_DATA_LOCATION = "${var.docker_appdata}/immich"
    DB_PASSWORD      = var.immich_db_password
    DB_USERNAME      = "immich"
    DB_DATABASE_NAME = "immich"
    TZ               = var.timezone
    UPLOAD_LOCATION  = var.nfs_photos
  }
}

module "nextcloud" {
  source      = "./modules/stack"
  name        = "nextcloud"
  yaml_file   = "${path.module}/docker/nextcloud.yaml"
  endpoint_id = portainer_environment.local.id
  env_vars = {
    DOCKER_APPDATA    = var.docker_appdata
    NFS_FILES         = var.nfs_files
    POSTGRES_PASSWORD = var.nextcloud_db_password
    PUID              = var.puid
    PGID              = var.pgid
    TZ                = var.timezone
  }
}
