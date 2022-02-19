#!/bin/bash

USER_HOME=/home/ubuntu
SCRIPTS_DIR=${USER_HOME}/pz-setup
ASSETS=${SCRIPTS_DIR}/assets
SETUP_DIR=${USER_HOME}/server-setup
SERVER_INPUT_PIPE=/tmp/srv-input

rm ${SERVER_INPUT_PIPE}
mkfifo ${SERVER_INPUT_PIPE}

cat > ${SERVER_INPUT_PIPE} &
echo $! > ${SERVER_INPUT_PIPE}-pid
echo password >> ${SERVER_INPUT_PIPE}
echo password >> ${SERVER_INPUT_PIPE}

# Send server startup message to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is starting. Please wait a few minutes before joining!\"}" "${DISCORD_WEBHOOK}"
fi

if [ -d "${USER_HOME}/Zomboid" ];
then
    ${SETUP_DIR}/start-server.sh
else
    ${SETUP_DIR}/start-server.sh < ${SERVER_INPUT_PIPE}
fi

# Send server exit to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is closed.\"}" "${DISCORD_WEBHOOK}"
fi
