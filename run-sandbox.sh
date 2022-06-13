#!/bin/bash

enterSandboxMsg() {
    echo -e "================="
    echo -e "\033[1;33mSandbox by Docker\033[0m"
    echo -e "================="
}

exitSandboxMsg() {
    echo -e "================="
    echo -e "\033[1;33mExit Sandbox\033[0m"
    echo -e "================="
    exit 0
}

runSandbox() {
DOCKER_CONFIG_FILE="$HOME/.docker"
DOCKER_DIR_MAPPING=""
if [ -d "$DOCKER_CONFIG_FILE" ]; then
    DOCKER_DIR_MAPPING="-v $HOME/.docker/config.json:/home/user/.docker/config.json"
fi

GIT_CONFIG_FILE="$HOME/.gitconfig"
GIT_CONFIG_MAPPING=""
if [ -f "$GIT_CONFIG_FILE" ]; then
    GIT_CONFIG_MAPPING="-v $HOME/.gitconfig:/home/user/.gitconfig:ro"
fi

SSH_CONFIG_FILE="$HOME/.ssh"
SSH_CONFIG_MAPPING=""
if [ -d "$SSH_CONFIG_FILE" ]; then
    SSH_CONFIG_MAPPING="-v $HOME/.ssh:/home/user/.ssh"
fi

docker run \
    -u root \
    -it \
    --rm \
    --network host \
    --env USER_ID=$(id -u) \
    --env GROUP_ID=$(id -g) \
    $GIT_CONFIG_MAPPING \
    $DOCKER_DIR_MAPPING \
    $SSH_CONFIG_MAPPING \
    -v $(pwd):/build \
    -v /etc/localtime:/etc/localtime:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    192.168.1.30:5000/core-frontend-sandbox:latest
}

enterSandboxMsg
runSandbox
exitSandboxMsg
