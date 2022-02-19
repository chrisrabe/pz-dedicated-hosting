#!/bin/bash

USER_HOME=/home/ubuntu
SCRIPTS_DIR=${USER_HOME}/pz-setup
ASSETS=${SCRIPTS_DIR}/assets
SETUP_DIR=${USER_HOME}/server-setup
SERVER_INPUT_PIPE=/tmp/srv-input
ADMIN_PASSWORD='password'

rm -f ${SERVER_INPUT_PIPE}
mkfifo ${SERVER_INPUT_PIPE}

cat > ${SERVER_INPUT_PIPE} &
echo $! > ${SERVER_INPUT_PIPE}-pid

# Send server startup message to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is starting. Please wait a few minutes before joining!\"}" "${DISCORD_WEBHOOK}"
fi

${SETUP_DIR}/start-server.sh < ${SERVER_INPUT_PIPE} &

# Set admin password for initial setup
if [ ! -d "${USER_HOME}/Zomboid" ];
then
    sleep 2s
    echo "${ADMIN_PASSWORD}" > ${SERVER_INPUT_PIPE}
    sleep 1s
    echo "${ADMIN_PASSWORD}" > ${SERVER_INPUT_PIPE}
    sleep 1s
    cat > ${SERVER_INPUT_PIPE}
fi

# Send server exit to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    sleep 1m
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is ready.\"}" "${DISCORD_WEBHOOK}"
fi
