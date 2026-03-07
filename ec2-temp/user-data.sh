#!/bin/bash
# Runs as root on first boot of the temp EC2 instance (Amazon Linux 2023).
# Installs Docker and Docker Compose plugin, then adds ec2-user to the docker group.

set -e

dnf update -y
dnf install -y docker git

systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Docker Compose v2 plugin
mkdir -p /usr/local/lib/docker/cli-plugins
curl -fsSL \
  "https://github.com/docker/compose/releases/download/v2.24.7/docker-compose-linux-x86_64" \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo "user-data: done"
