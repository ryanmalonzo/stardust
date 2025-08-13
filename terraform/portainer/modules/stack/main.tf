data "local_file" "compose" {
  filename = var.yaml_file
}

resource "portainer_stack" "this" {
  name            = var.name
  deployment_type = "standalone"
  method          = "string"
  endpoint_id     = var.endpoint_id

  stack_file_content = data.local_file.compose.content

  dynamic "env" {
    for_each = var.env_vars
    content {
      name  = env.key
      value = env.value
    }
  }
}
