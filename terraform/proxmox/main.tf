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

resource "proxmox_virtual_environment_download_file" "debian_12_genericcloud" {
  content_type = "import"
  datastore_id = data.proxmox_virtual_environment_datastores.terraform.datastores[0].id
  node_name    = "pve"
  url          = "https://cdimage.debian.org/cdimage/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "proxmox_virtual_environment_download_file" "debian_12_generic" {
  content_type = "import"
  datastore_id = data.proxmox_virtual_environment_datastores.terraform.datastores[0].id
  node_name    = "pve"
  url          = "https://cdimage.debian.org/cdimage/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
}

resource "proxmox_virtual_environment_file" "cloud_init" {
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

resource "proxmox_virtual_environment_vm" "docker" {
  name      = "docker"
  node_name = var.proxmox_node_name

  machine = "q35"

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
    datastore_id = "local-lvm"
    import_from  = proxmox_virtual_environment_download_file.debian_12_generic.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 50
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_init.id
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

  # GPU passthrough
  hostpci {
    device = "hostpci0"
    id     = var.gpu_pci_id
    pcie   = true
    rombar = true
    xvga   = false
  }
}
