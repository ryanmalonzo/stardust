.PHONY: install bootstrap docker newt

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
