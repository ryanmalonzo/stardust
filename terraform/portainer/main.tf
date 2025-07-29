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
    name  = "ZFS_MEDIA"
    value = var.zfs_media
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
}
