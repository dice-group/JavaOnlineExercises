#!/bin/bash

# This file builds and runs a docker container based on a docker image.
# It publishes a nbgrader container port to a host port.
# It mounts the home directory for backups.



# Comment for enabling script

echo "Script disabled." ; exit



# Configuration

IMAGE_NAME="nbgjava"
TAG_NAME="latest"

CONTAINER_NAME="nbgjava"

PORT_HOST="443"
PORT_CONTAINER="8000"

# Mount point to create backups
MOUNT_DIR_HOST="/tmp/mnt_nbg"
MOUNT_DIR_CONTAINER="/home/nbgadmin"



# Execution

docker run \
-t -d \
-p $PORT_HOST:$PORT_CONTAINER \
-v $MOUNT_DIR_HOST:$MOUNT_DIR_CONTAINER \
--name $CONTAINER_NAME \
$IMAGE_NAME:$TAG_NAME
