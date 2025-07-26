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

data "local_file" "ssh_public_key" {
  filename = "${path.module}/ssh/key.pub"
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
      ssh_key  = trimspace(data.local_file.ssh_public_key.content)
    })

    file_name = "docker-cloud-init.yaml"
  }
}
