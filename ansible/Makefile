.PHONY: install zfs-pool zfs-dataset nfs-server media-dirs nfs-client bootstrap docker newt portainer help

zfs-pool:
	ansible-playbook playbooks/00-create-zfs-pool.yml

zfs-dataset:
	ansible-playbook playbooks/01-create-zfs-dataset.yml

nfs-server:
	ansible-playbook playbooks/02-install-nfs-server.yml

media-dirs:
	ansible-playbook playbooks/03-create-media-dirs.yml

nfs-client:
	ansible-playbook playbooks/04-mount-nfs-client.yml

bootstrap:
	ansible-playbook playbooks/05-bootstrap-pangolin.yml

docker:
	ansible-playbook playbooks/06-install-docker.yml



socket-proxy:
	ansible-playbook playbooks/07-deploy-socket-proxy.yml


newt:
	ansible-playbook playbooks/08-deploy-newt-agent.yml


portainer:
	ansible-playbook playbooks/09-deploy-portainer-be.yml

install:
	ansible-galaxy install -r requirements.yml

intel-vaapi:
	ansible-playbook playbooks/10-install-intel-vaapi.yml

help:
	@echo "Available commands:"
	@echo "  zfs-pool      - Create the ZFS pool on Proxmox host"
	@echo "  zfs-dataset   - Create the ZFS dataset on Proxmox host"
	@echo "  nfs-server    - Install and configure NFS server on Proxmox host"
	@echo "  media-dirs    - Create media directories for anime/non-anime separation"
	@echo "  nfs-client    - Mount NFS share on Docker VM"
	@echo "  bootstrap     - Bootstrap the Pangolin VM (user, SSH, sudo)"
	@echo "  docker        - Install Docker on Docker and Pangolin VMs"
	@echo "  socket-proxy  - Create Docker network and volume, then deploy socket proxy stack"
	@echo "  newt          - Deploy Newt agent on Docker VM"
	@echo "  portainer     - Deploy Portainer on Docker VM"
	@echo "  intel-vaapi   - Install Intel VAAPI drivers on Docker VM"
	@echo "  install       - Install Ansible Galaxy requirements"

.DEFAULT_GOAL := help
