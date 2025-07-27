provider "scaleway" {
  zone   = var.scaleway_zone
  region = var.scaleway_region
}

resource "scaleway_instance_security_group" "www" {
  project_id              = var.scaleway_project_id
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }

  # Wireguard
  inbound_rule {
    action   = "accept"
    port     = "51820"
    protocol = "UDP"
  }
}

resource "scaleway_instance_ip" "pangolin_vm_ip" {
  project_id = var.scaleway_project_id
  type       = "routed_ipv6"
}

resource "scaleway_instance_server" "pangolin_vm" {
  project_id = var.scaleway_project_id

  type      = "STARDUST1-S"
  image     = "debian_bookworm"
  protected = true

  root_volume {
    delete_on_termination = false
  }

  ip_id = scaleway_instance_ip.pangolin_vm_ip.id

  security_group_id = scaleway_instance_security_group.www.id
}
