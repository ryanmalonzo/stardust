terraform {
  required_version = ">= 1.12"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
    portainer = {
      source  = "portainer/portainer"
      version = "1.9.0"
    }
  }
}
