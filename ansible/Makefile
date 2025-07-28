.PHONY: install bootstrap docker newt

nfs:
	ansible-playbook playbooks/00-install-nfs-server.yml

bootstrap:
	ansible-playbook playbooks/01-bootstrap-pangolin.yml

docker:
	ansible-playbook playbooks/02-install-docker.yml

newt:
	ansible-playbook playbooks/03-deploy-newt-agent.yml

portainer:
	ansible-playbook playbooks/04-deploy-portainer-be.yml

install:
	ansible-galaxy install -r requirements.yml
