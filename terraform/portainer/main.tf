resource "portainer_environment" "local" {
  name                   = "local"
  environment_address    = "unix:///var/run/docker.sock"
  type                   = 1
  tls_enabled            = true
  tls_skip_client_verify = true
  tls_skip_verify        = true
}

resource "portainer_stack" "backrest" {
  name            = "backrest"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = portainer_environment.local.id

  stack_file_path = "./docker/backrest.yaml"

  env {
    name  = "DOCKER_VOLUMES_ROOT"
    value = var.docker_volumes_root
  }

  env {
    name  = "TZ"
    value = var.timezone
  }
}
