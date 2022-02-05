#!/bin/bash

USER_HOME=/home/ubuntu
START_SCRIPTS=https://github.com/chrisrabe/pz-dedicated-hosting.git
SCRIPTS_DIR=${USER_HOME}/pz-setup
SETUP_DIR=${USER_HOME}/server-setup
STEAM_APP_ID=380870
AWS_DIR=${SCRIPTS_DIR}/aws
ASSETS_DIR=${SCRIPTS_DIR}/assets
DISCORD_WEBHOOK=''

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

# Clone set up scripts
git clone ${START_SCRIPTS} ${SCRIPTS_DIR}

chown -R ubuntu:ubuntu ${SETUP_DIR}
chown -R ubuntu:ubuntu ${SCRIPTS_DIR}

# Insert discord webhook in .bashrc (so it's available globally)
echo "export DISCORD_WEBHOOK=${DISCORD_WEBHOOK}" >> ${USER_HOME}/.bashrc
source ${USER_HOME}/.bashrc

# Send server initialisation message to discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is initialised. Please log into it to continue set up.\"}" "${DISCORD_WEBHOOK}"
fi
