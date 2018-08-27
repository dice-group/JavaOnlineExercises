#!/bin/bash

# This file builds and runs a docker container.
# It publishes a nbgrader container port to a host port.
# It mounts the home directory for backups.
# It mounts the database directory for backups.

IMAGE_NAME="diceapp"
TAG_NAME="latest"
CONTAINER_NAME="diceapp"
PORT_HOST="443"
PORT_CONTAINER="8000"
MOUNT_DIR_HOME="/tmp/mnt/database"
MOUNT_DIR_DATABASE="/tmp/mnt/home"

docker run \
-t -d \
-p $PORT_HOST:$PORT_CONTAINER \
-v $MOUNT_DIR_HOME:/srv/jupyterhub \
-v $MOUNT_DIR_DATABASE:/home \
--name $CONTAINER_NAME \
$IMAGE_NAME:$TAG_NAME
