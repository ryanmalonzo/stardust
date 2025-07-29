output "docker_vm_id" {
  value = proxmox_virtual_environment_vm.docker.id
}

output "docker_vm_ip" {
  value = proxmox_virtual_environment_vm.docker.ipv4_addresses[1][0]
}
