#!/bin/bash

# This file executes a command to access a bash inside a docker container.



# Configuration

CONTAINER_NAME="nbgjava"



# Ensure correct working directory

cd "$(dirname "$0")"



# If container.txt exists, the including container name will be used.

if [ -e container.txt ]
then
    CONTAINER_NAME=`cat container.txt`
fi



# Access bash

docker exec --interactive --tty $CONTAINER_NAME /bin/bash
