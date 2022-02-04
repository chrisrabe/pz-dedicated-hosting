#!/bin/bash

# Install Docker Engine
sudo snap install docker
sudo addgroup --system docker
sudo adduser ubuntu docker
newgrp docker
sudo snap disable docker
sudo snap enable docker

# Set up firewalls
