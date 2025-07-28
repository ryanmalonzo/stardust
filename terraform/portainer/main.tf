provider "portainer" {
  endpoint = var.portainer_endpoint
  username = var.portainer_username
  password = var.portainer_password
}

# Example: Deploy a stack via Portainer
resource "portainer_stack" "example" {
  name = "example-stack"
  # Compose file or other stack config here
  # ...
}
