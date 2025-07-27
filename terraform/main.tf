output "docker_vm_id" {
  value = proxmox_virtual_environment_vm.docker_vm.id
}

output "docker_vm_ip" {
  value = proxmox_virtual_environment_vm.docker_vm.ipv4_addresses[1][0]
}
