data "local_file" "ssh_public_key_file" {
  filename = "${path.module}/../keys/key.pub"
}

locals {
  ssh_public_key = trimspace(data.local_file.ssh_public_key_file.content)
}

output "docker_vm_id" {
  value = proxmox_virtual_environment_vm.docker_vm.id
}

output "docker_vm_ip" {
  value = proxmox_virtual_environment_vm.docker_vm.ipv4_addresses[1][0]
}

# output "pangolin_vm_id" {
#   value = scaleway_instance_server.pangolin_vm.id
# }

# output "pangolin_vm_ip" {
#   value = scaleway_instance_server.pangolin_vm.public_ips[0].address
# }
