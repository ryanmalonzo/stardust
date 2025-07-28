terraform {
  required_version = ">= 1.12"

  required_providers {
    portainer = {
      source  = "portainer/portainer"
      version = "1.9.0"
    }
  }
}
