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
    name  = "BACKREST_ROOT"
    value = "/opt/backrest"
  }

  env {
    name  = "DOCKER_VOLUMES_ROOT"
    value = var.docker_volumes_root
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
    name  = "DOCKER_VOLUMES_ROOT"
    value = var.docker_volumes_root
  }
}
