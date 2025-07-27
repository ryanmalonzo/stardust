provider "proxmox" {
  endpoint = var.proxmox_endpoint_url
  insecure = true
}

data "proxmox_virtual_environment_datastores" "terraform" {
  node_name = var.proxmox_node_name
  filters = {
    id = "terraform"
  }
}

data "proxmox_virtual_environment_datastores" "zfs" {
  node_name = var.proxmox_node_name
  filters = {
    id = "tank"
  }
}

resource "proxmox_virtual_environment_download_file" "debian_12_genericcloud" {
  content_type = "import"
  datastore_id = data.proxmox_virtual_environment_datastores.terraform.datastores[0].id
  node_name    = "pve"
  url          = "https://cdimage.debian.org/cdimage/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "proxmox_virtual_environment_file" "docker_cloud_init" {
  content_type = "snippets"
  datastore_id = data.proxmox_virtual_environment_datastores.terraform.datastores[0].id
  node_name    = var.proxmox_node_name

  source_raw {
    data = templatefile("${path.module}/cloud-init/common.yaml", {
      hostname = "docker"
      timezone = var.timezone
      username = "stardust"
      ssh_key  = local.ssh_public_key
    })

    file_name = "docker-cloud-init.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "docker_vm" {
  name      = "docker"
  node_name = var.proxmox_node_name

  agent {
    enabled = true
  }

  cpu {
    cores = 4
  }

  memory {
    dedicated = 16384
  }

  disk {
    datastore_id = data.proxmox_virtual_environment_datastores.zfs.datastores[0].id
    import_from  = proxmox_virtual_environment_download_file.debian_12_genericcloud.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 1024
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.docker_cloud_init.id
  }

  network_device {
    bridge = "vmbr0"
  }

  serial_device {
    device = "socket"
  }
  vga {
    type = "serial0"
  }
}
