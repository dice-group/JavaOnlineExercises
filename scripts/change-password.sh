#!/bin/bash

# This file sets a new password for a linux user



# Configuration

CONTAINER_NAME="nbgjava"



# Ensure correct working directory

cd "$(dirname "$0")"



# If container.txt exists, the including container name will be used.

if [ -e container.txt ]
then
    CONTAINER_NAME=`cat container.txt`
fi



# Check input parameters

if [ $# -ne 2 ]; then
    echo "change-password.sh <id> <uncrypted password>"
    echo "Sets a new password for a linux user"
    echo "Container: $CONTAINER_NAME"
    exit 1
fi

ID=$1
UNCRYPTED_PASSWORD=$2



# Execution

ENCRYPTED_PASSWORD=$(openssl passwd -1 $UNCRYPTED_PASSWORD)
ESCAPED_PASSWORD="${ENCRYPTED_PASSWORD//\$/\\\$}"

if [ ${#ENCRYPTED_PASSWORD} -ne 34 ]; then
    echo "Error: The escaped pasword length is not 34."
    exit 2
fi

docker exec $CONTAINER_NAME usermod --password $ENCRYPTED_PASSWORD $ID
