#!/bin/bash

# Install Docker Engine
sudo snap install docker
sudo addgroup --system docker
sudo adduser ubuntu docker
newgrp docker
sudo snap disable docker
sudo snap enable docker

# Set up firewalls
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 8766/udp
sudo ufw allow 16261/udp
sudo ufw allow 16262:16272/tcp
