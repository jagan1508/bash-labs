# Vagrant VM Deployment with HTTPD

## Project Overview
This project automates the creation of four virtual machines (VMs) using Vagrant and deploys a static website using the `httpd` service. The setup consists of three web servers (`web01`, `web02`, and `web03`) and a dedicated scripting machine (`scriptbox`).

## VM Configuration
- **web01**: CentOS, running HTTPD
- **web02**: CentOS, running HTTPD
- **web03**: Ubuntu, running Apache2
- **scriptbox**: A separate VM used to manage and deploy the website

## Prerequisites
- Install [Vagrant](https://www.vagrantup.com/)
- Install [VirtualBox](https://www.virtualbox.org/)
- Clone this repository

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd <repo-folder>
   ```
2. Start the VMs using Vagrant:
   ```bash
   vagrant up
   ```
3. Verify the VMs are running:
   ```bash
   vagrant status
   ```
4. SSH into the scriptbox VM to execute deployment scripts:
   ```bash
   vagrant ssh scriptbox
   ```
5. Deploy the static website from scriptbox:
   ```bash
   ./deploy_script.sh
   ```

## Deployment Details
- The scriptbox VM contains automation scripts to install and configure `httpd` (Apache) on CentOS-based web servers and `apache2` on Ubuntu.
- The static website files are copied to `/var/www/html/` on each web server.
- The HTTPD service is enabled and started automatically.

## Verification
After deployment, you can check if the web servers are running by accessing them in a browser:
```
http://<web01-ip>
http://<web02-ip>
http://<web03-ip>
```
Alternatively, run:
```bash
curl http://<web-server-ip>
```

## Troubleshooting
- If a VM fails to start, run:
  ```bash
  vagrant reload --provision
  ```
- Check Apache status:
  ```bash
  systemctl status httpd  # For CentOS
  systemctl status apache2  # For Ubuntu
  ```
- Inspect logs for errors:
  ```bash
  tail -f /var/log/httpd/access_log  # CentOS
  tail -f /var/log/apache2/access.log  # Ubuntu
  ```

## Cleanup
To destroy all VMs:
```bash
vagrant destroy -f
```
