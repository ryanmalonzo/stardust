.PHONY: install zfs-pool zfs-dataset nfs-server nfs-client bootstrap docker newt portainer

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
	ansible-playbook playbooks/07-deploy-portainer.yml

install:
	ansible-galaxy install -r requirements.yml