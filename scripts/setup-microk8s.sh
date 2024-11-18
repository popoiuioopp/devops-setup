#!/bin/bash

# Install Microk8s
sudo snap install microk8s --classic

# Add user to Microk8s group
sudo usermod -aG microk8s $USER
sudo chown -R $USER ~/.kube
newgrp microk8s

# Enable add-ons
microk8s enable dns ingress storage

# Install Docker
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker $USER
newgrp docker

# Create Cloudflared secret
microk8s.kubectl create secret generic cloudflared-token \
  --from-literal=token='<your-cloudflare-tunnel-token>'

echo "Microk8s setup completed successfully!"
