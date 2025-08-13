resource "portainer_environment" "local" {
  name                   = "local"
  environment_address    = "unix:///var/run/docker.sock"
  type                   = 1
  tls_enabled            = true
  tls_skip_client_verify = true
  tls_skip_verify        = true
}

data "local_file" "backrest" {
  filename = "${path.module}/docker/backrest.yaml"
}

resource "portainer_stack" "backrest" {
  name            = "backrest"
  deployment_type = "standalone"
  method          = "string"
  endpoint_id     = portainer_environment.local.id

  stack_file_content = data.local_file.backrest.content

  env {
    name  = "DOCKER_BACKREST"
    value = "/opt/backrest"
  }

  env {
    name  = "DOCKER_APPDATA"
    value = var.docker_appdata
  }

  env {
    name  = "TZ"
    value = var.timezone
  }
}

data "local_file" "vaultwarden" {
  filename = "${path.module}/docker/vaultwarden.yaml"
}

resource "portainer_stack" "vaultwarden" {
  name            = "vaultwarden"
  deployment_type = "standalone"
  method          = "string"
  endpoint_id     = portainer_environment.local.id

  stack_file_content = data.local_file.vaultwarden.content

  env {
    name  = "DOCKER_APPDATA"
    value = var.docker_appdata
  }
}

data "local_file" "jellyfin" {
  filename = "${path.module}/docker/jellyfin.yaml"
}

resource "portainer_stack" "jellyfin" {
  name            = "jellyfin"
  deployment_type = "standalone"
  method          = "string"
  endpoint_id     = portainer_environment.local.id

  stack_file_content = data.local_file.jellyfin.content

  env {
    name  = "DOCKER_APPDATA"
    value = var.docker_appdata
  }

  env {
    name  = "NFS_MEDIA"
    value = var.nfs_media
  }

  env {
    name  = "TZ"
    value = var.timezone
  }

  env {
    name  = "PUID"
    value = var.puid
  }

  env {
    name  = "PGID"
    value = var.pgid
  }

  env {
    name  = "INCOMPLETE_DOWNLOADS_DIR"
    value = var.incomplete_downloads_dir
  }

  env {
    name  = "DOWNLOADS_DIR"
    value = var.downloads_dir
  }
}

data "local_file" "immich" {
  filename = "${path.module}/docker/immich.yaml"
}

resource "portainer_stack" "immich" {
  name            = "immich"
  deployment_type = "standalone"
  method          = "string"
  endpoint_id     = portainer_environment.local.id

  stack_file_content = data.local_file.immich.content

  env {
    name  = "DB_DATA_LOCATION"
    value = "${var.docker_appdata}/immich"
  }

  env {
    name  = "DB_PASSWORD"
    value = var.immich_db_password
  }

  env {
    name  = "DB_USERNAME"
    value = "immich"
  }

  env {
    name  = "DB_DATABASE_NAME"
    value = "immich"
  }

  env {
    name  = "TZ"
    value = var.timezone
  }

  env {
    name  = "UPLOAD_LOCATION"
    value = var.nfs_photos
  }
}
