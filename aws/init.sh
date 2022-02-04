#!/bin/bash

USER_HOME=/home/ubuntu
SETUP_DIR=${USER_HOME}/server-setup
STEAM_APP_ID=380870

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

# Download PZ server using docker container
mkdir ${SETUP_DIR} && cd ${SETUP_DIR}
docker run -i -v ${PWD}:/data steamcmd/steamcmd:latest +login anonymous +force_install_dir /data +app_update ${STEAM_APP_ID} +quit

# Start server (to create the server configuration)
# Stop server
# Modify the server files
# Start server again
