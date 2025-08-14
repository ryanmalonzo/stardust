# Stardust

A semi-automated personal homelab infrastructure setup using Terraform for infrastructure deployment and Docker services (Portainer), and Ansible for system configuration. This project orchestrates the deployment of a Proxmox-based homelab with containerized services and cloud integration.

## Environment Variables

The following environment variables need to be configured before running the deployment steps. You can set these in a `.envrc` file or export them in your shell:

| Variable                      | Description                             | Example                         |
| ----------------------------- | --------------------------------------- | ------------------------------- |
| `CLOUDFLARE_API_TOKEN`        | Cloudflare API token for DNS management | `your_cloudflare_token`         |
| `NEWT_ID`                     | Newt service identifier                 | `your_newt_id`                  |
| `NEWT_SECRET`                 | Newt service secret key                 | `your_newt_secret`              |
| `PANGOLIN_IP`                 | IP address of the Pangolin VPS          | `217.154.121.137`               |
| `PORTAINER_ENDPOINT`          | Portainer web interface URL             | `https://portainer.example.com` |
| `PORTAINER_API_KEY`           | Portainer API key for automation        | `ptr_your_api_key`              |
| `PROXMOX_VE_ENDPOINT_URL`     | Proxmox VE web interface URL            | `https://192.168.1.35:8006/`    |
| `PROXMOX_VE_USERNAME`         | Proxmox VE username                     | `root@pam`                      |
| `PROXMOX_VE_PASSWORD`         | Proxmox VE password                     | `your_password`                 |
| `TF_VAR_pangolin_ip`          | Terraform variable for Pangolin IP      | `$PANGOLIN_IP`                  |
| `TF_VAR_proxmox_endpoint_url` | Terraform variable for Proxmox URL      | `$PROXMOX_VE_ENDPOINT_URL`      |

## Deployment Steps

> **Note**: SSH keys must be added manually to all hosts before running automated steps.
>
> **Note**: Static IP leases must be configured in your DHCP server for the Proxmox host and each VM to ensure consistent network addressing.

### 1. Install Proxmox VE

Install Proxmox VE on the hardware (manual step)

### 2. Create ZFS Pool

Create ZFS pool with two HDDs using Ansible:

```bash
make zfs-pool
```

### 3. Create ZFS Dataset

Create ZFS dataset `tank/media` using Ansible:

```bash
make zfs-dataset
```

### 4. Install NFS Server

Install NFS server on the Proxmox host using Ansible:

```bash
make nfs-server
```

### 5. Configure NFS in Proxmox

Add NFS server to Proxmox via the web UI (manual step)

### 6. Mount NFS Client

Install NFS client and mount it to the Docker VM using Ansible:

```bash
make nfs-client
```

### 7. Create Docker VM

Create Debian VM for Docker services using Terraform:

```bash
cd terraform/proxmox
terraform apply
```

### 8. Setup Cloud VPS

Purchase and configure cloud VPS for Pangolin (manual step)

### 9. Install Docker

Install Docker on both Docker and Pangolin VMs using Ansible:

```bash
make docker
```

### 10. Deploy Docker Socket Proxy

Deploy the Docker socket proxy stack to the Docker VM using Ansible:

```bash
make socket-proxy
```

### 11. Install Intel VAAPI and Firmware (Docker VM)

Install Intel VAAPI drivers and firmware on the Docker VM using Ansible:

```bash
make intel-vaapi
```

### 12. Deploy Newt Agent

Deploy Newt agent on the Docker VM using Ansible:

```bash
make newt
```

### 13. Deploy Portainer

Deploy Portainer on the Docker VM using Ansible:

```bash
make portainer
```

### 14. Deploy Application Stacks

Deploy stacks via Portainer using Terraform:

```bash
cd terraform/portainer
terraform apply
```

### 15. Configure DNS

Manage Cloudflare DNS records using Terraform:

```bash
cd terraform/cloudflare
terraform apply
```

### 16. Setup Tunnels

Add tunnels via the Pangolin web UI (manual step)
