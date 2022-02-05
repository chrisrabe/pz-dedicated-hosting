#!/bin/bash

USER_HOME=/home/ubuntu
SCRIPTS_DIR=${USER_HOME}/pz-setup
ASSETS=${SCRIPTS_DIR}/assets
SETUP_DIR=${USER_HOME}/server-setup

${SETUP_DIR}/start-server.sh < ${ASSETS}/serv-creds.txt
