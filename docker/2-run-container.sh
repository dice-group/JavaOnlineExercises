#!/bin/bash

# This file builds and runs a docker container based on a docker image.
# It publishes a nbgrader container port to a host port.
# It mounts the home directory for backups.



# Uncomment for disabling script (as it has to be executed only one time)

#echo "Script disabled." ; exit



# Configuration

CONTAINER_NAME="nbgjava"
PORT_HOST="8000"
MOUNT_DIR_HOST="/mnt/nbgjava"

# Image source for the container to create
IMAGE_NAME="nbgjava"
TAG_NAME="latest"

# Static Container configuration
MOUNT_DIR_CONTAINER="/home/nbgadmin"
PORT_CONTAINER="8000"



# Ensure correct working directory

cd "$(dirname "$0")"



# Execution

docker run \
-t -d \
-p $PORT_HOST:$PORT_CONTAINER \
-v $MOUNT_DIR_HOST:$MOUNT_DIR_CONTAINER \
--name $CONTAINER_NAME \
$IMAGE_NAME:$TAG_NAME



# Create container info in scripts directory

if [ -e ../scripts ]
then
    echo $CONTAINER_NAME > ../scripts/container.txt
fi



# Restore admin home

docker exec $CONTAINER_NAME [ -d /home/nbgadmin ] || mkdir /home/nbgadmin
docker exec $CONTAINER_NAME cp -Rp /home/.nbgadmin/. /home/nbgadmin/
