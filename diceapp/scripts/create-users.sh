#!/bin/bash

# This file reads a CSV file and creates linux users inside a docker container.

if [ $# -ne 1 ]; then
    echo "create-users.sh <file>"
    exit 1
fi

if [ -r $1 ];then
    echo "Reading $1"
else
    echo "Can not read $1"
    exit 2
fi

while IFS=',' read -r U P || [[ -n "$LINE" ]]; do
    ./create-user.sh $U $P
done < "$1"
