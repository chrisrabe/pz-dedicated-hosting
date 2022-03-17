USER_HOME=/home/ubuntu
SETUP_DIR=${USER_HOME}/server-setup
STEAM_APP_ID=380870


# Send server startup message to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Currently updating server (${SERVER_IP}). Please wait.\"}" "${DISCORD_WEBHOOK}"
fi

docker run -i -v ${SETUP_DIR}:/data steamcmd/steamcmd:latest +login anonymous +force_install_dir /data +app_update ${STEAM_APP_ID} validate +quit

# Send server exit to Discord
if [ ! -z "${DISCORD_WEBHOOK}" ];
then
    SERVER_IP=$(curl http://checkip.amazonaws.com)
    curl -H "Content-Type: application/json" -d "{\"content\": \"Server at ${SERVER_IP} is updated.\"}" "${DISCORD_WEBHOOK}"
fi
