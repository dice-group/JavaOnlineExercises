#!/bin/bash

# This file creates a linux user inside a docker container.

CONTAINER_NAME="diceapp"

if [ $# -ne 2 ]; then
    echo "create-user.sh <username> <password>"
    exit 1
fi

docker exec $CONTAINER_NAME useradd --create-home $1
P=$(openssl passwd -1 $2)
docker exec $CONTAINER_NAME usermod --password $P $1
