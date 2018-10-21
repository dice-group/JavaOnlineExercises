#!/bin/bash

# This file adds a student account to a docker container:
# - A linux user is added
# - The nbgrader gradebook database is updated
#
# Please ensure an encrypted password



# Configuration

CONTAINER_NAME="nbgjava"
COURSE_DIR="/home/nbgadmin/"



# Ensure correct working directory

cd "$(dirname "$0")"



# If container.txt exists, the including container name will be used.

if [ -e container.txt ]
then
    CONTAINER_NAME=`cat container.txt`
fi



# Check input parameters

if [ $# -ne 5 ]; then
    echo "create-student.sh <id> <encrypted password> <first name> <surname> <email>"
    echo "Creates a student account (linux user and nbgrader database)"
    echo "Container:        $CONTAINER_NAME"
    echo "Course directory: $COURSE_DIR"
    exit 1
fi

ID=$1
ENCRYPTED_PASSWORD=$2
FIRST_NAME=$3
SURNAME=$4
EMAIL=$5

if [ ${#ENCRYPTED_PASSWORD} -ne 34 ]; then
    echo "Error: The pasword length is not 34. Use \"openssl passwd -1 <password>\"."
    exit 2
fi



# Execution

docker exec $CONTAINER_NAME adduser --gecos "" --disabled-password "$ID"
docker exec $CONTAINER_NAME usermod --password "$ENCRYPTED_PASSWORD" "$ID"
docker exec $CONTAINER_NAME chgrp nbgadmin "/home/$ID"
docker exec $CONTAINER_NAME nbgrader db student add --course-dir="$COURSE_DIR" --first-name="$FIRST_NAME" --last-name="$SURNAME" --email="$EMAIL" "$ID"
