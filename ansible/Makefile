.PHONY: install zfs-pool zfs-dataset nfs-server nfs-client bootstrap docker newt portainer help

zfs-pool:
	ansible-playbook playbooks/00-create-zfs-pool.yml

zfs-dataset:
	ansible-playbook playbooks/01-create-zfs-dataset.yml

nfs-server:
	ansible-playbook playbooks/02-install-nfs-server.yml

nfs-client:
	ansible-playbook playbooks/03-mount-nfs-client.yml

bootstrap:
	ansible-playbook playbooks/04-bootstrap-pangolin.yml

docker:
	ansible-playbook playbooks/05-install-docker.yml

newt:
	ansible-playbook playbooks/06-deploy-newt-agent.yml

portainer:
	ansible-playbook playbooks/07-deploy-portainer-be.yml

install:
	ansible-galaxy install -r requirements.yml

help:
	@echo "Available commands:"
	@echo "  zfs-pool     - Create the ZFS pool on Proxmox host"
	@echo "  zfs-dataset  - Create the ZFS dataset on Proxmox host"
	@echo "  nfs-server   - Install and configure NFS server on Proxmox host"
	@echo "  nfs-client   - Mount NFS share on Docker VM"
	@echo "  bootstrap    - Bootstrap the Pangolin VM (user, SSH, sudo)"
	@echo "  docker       - Install Docker on Docker and Pangolin VMs"
	@echo "  newt         - Deploy Newt agent on Docker VM"
	@echo "  portainer    - Deploy Portainer on Docker VM"
	@echo "  install      - Install Ansible Galaxy requirements"

.DEFAULT_GOAL := help
