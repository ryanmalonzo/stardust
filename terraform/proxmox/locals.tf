data "local_file" "ssh_public_key_file" {
  filename = "${path.module}/../../keys/key.pub"
}

locals {
  ssh_public_key = trimspace(data.local_file.ssh_public_key_file.content)
}
