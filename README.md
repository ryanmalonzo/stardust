# stardust

## Deployment Workflow

Here’s the recommended deployment workflow for this project, with each step marked as automated (via Ansible, Terraform, or Makefile) or manual. This should help you understand what’s hands-off and what still needs a human touch.

1. **Install Proxmox** _(manual)_
   - Install Proxmox VE on your hardware. This can’t be automated from outside.
2. **Create ZFS pool with 2 HDDs** _(automated: Ansible/Makefile)_
   - Run `make zfs-pool` to ensure the ZFS pool exists.
3. **Create ZFS dataset `tank/media`** _(automated: Ansible/Makefile)_
   - Run `make zfs-dataset` to ensure the dataset exists.
4. **Install NFS server on Proxmox host** _(automated: Ansible/Makefile)_
   - Run `make nfs-server`.
5. **Add NFS server to Proxmox via Web UI** _(manual)_
   - Use the Proxmox web UI to add the NFS storage backend.
6. **Install NFS client and mount it to Docker VM** _(automated: Ansible/Makefile)_
   - Run `make nfs-client`.
7. **Distribute SSH key to Proxmox host** _(automated: Ansible/Makefile)_
   - Run `make ssh-key` to push your SSH key using initial credentials.
8. **Create Debian VM to run Docker services (“the Docker VM”)** _(automated: Terraform)_
   - Use the Terraform configuration in `terraform/proxmox`.
9. **Add SSH key to Docker host** _(automated: Terraform)_
   - Handled by cloud-init in Terraform.
10. **Purchase Cloud VPS to run Pangolin on** _(manual)_
    - Buy a VPS from your provider of choice.
11. **Add SSH key to Pangolin host root user** _(automated: Ansible/Makefile)_
    - Run `make ssh-key` with the right inventory/host.
12. **Add SSH key to Pangolin host stardust user** _(automated: Ansible/Makefile)_
    - Run `make ssh-key` with the right inventory/host.
13. **Install Docker on Docker and Pangolin VMs** _(automated: Ansible/Makefile)_
    - Run `make docker`.
14. **Deploy Newt agent on Pangolin VM** _(automated: Ansible/Makefile)_
    - Run `make newt`.
15. **Deploy Portainer on Docker VM** _(automated: Ansible/Makefile)_
    - Run `make portainer`.
16. **Deploy stacks via Portainer** _(automated: Terraform)_
    - Use the Terraform configuration in `terraform/portainer`.
17. **Cloudflare DNS records** _(automated: Terraform)_
    - Use the Terraform configuration in `terraform/cloudflare`.
18. **Tunnels via Pangolin Web UI** _(manual)_
    - Add tunnels using the Pangolin web UI (no API or Terraform provider as of now).

---

### Notes

- All Ansible playbooks are in `ansible/playbooks/` and can be run via the Makefile.
- SSH key distribution is idempotent and can be run multiple times safely.
- ZFS pool and dataset creation are also idempotent and will not change anything if already set up.
- For any manual steps, see the Proxmox or Pangolin documentation for details.
