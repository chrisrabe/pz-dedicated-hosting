#!/bin/bash

USER_HOME=/home/ubuntu
ZOMBOID_DIR=${USER_HOME}/Zomboid/Server
SCRIPTS_DIR=${USER_HOME}/pz-setup
SERVER_SPECS=${SCRIPTS_DIR}/specs

FILES=(
    "servertest.ini",
    "servertest_SandboxVars.lua",
    "servertest_spawnregions.lue"
)

for f in "${FILES[@]}"
do
    cp "${SERVER_SPECS}/${f}" "${ZOMBOID_DIR}/${f}"
done
