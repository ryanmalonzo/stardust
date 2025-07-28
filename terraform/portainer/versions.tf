terraform {
  required_version = ">= 1.12"

  required_providers {
    portainer = {
      source  = "Parallels/portainer"
      version = ">= 1.0.0"
    }
  }
}
