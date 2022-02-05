#!/bin/bash

USER_HOME=/home/ubuntu
ZOMBOID_DIR=${USER_HOME}/Zomboid/Server
SCRIPTS_DIR=${USER_HOME}/pz-setup
SERVER_SPECS=${SCRIPTS_DIR}/specs

FILES=(
    "servertest.ini"
    "servertest_SandboxVars.lua"
    "servertest_spawnregions.lua"
)

for f in "${FILES[@]}"
do
    # Send server startup message to Discord
    if [ ! -z "${DISCORD_WEBHOOK}" ];
    then
        SERVER_IP=$(curl http://checkip.amazonaws.com)
        curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} has configured ${f}!\"}" "${DISCORD_WEBHOOK}"
    fi
    cp "${SERVER_SPECS}/${f}" "${ZOMBOID_DIR}/${f}"
done
