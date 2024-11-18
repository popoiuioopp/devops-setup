#!/bin/bash

sudo usermod -aG microk8s $USER
sudo chown -R $USER ~/.kube
newgrp microk8s

# Enable add-ons
microk8s enable dns
microk8s enable ingress
microk8s enable storage

sudo usermod -aG docker $USER
newgrp docker

wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg --install cloudflared-linux-amd64.deb

exec "$SHELL"

# Cloudflared Setup
cloudflared tunnel login

# cloudflared tunnel create <YOUR TUNNEL NAME>
# kubectl create secret generic tunnel-credentials --from-file=credentials.json=<YOUR FILE>

echo "Microk8s setup completed successfully!"
