#!/bin/bash

# This file builds a docker image based on a dockerfile.
# The output is written to build.log



# Comment for enabling script

echo "Script disabled." ; exit



# Configuration

IMAGE_NAME="nbgjava"
TAG_NAME="latest"



# Execution

echo "Monitor the progress with: tail -f -n 20 build.log"
docker build -t $IMAGE_NAME:$TAG_NAME . >> build.log
echo ""
echo "Please set the passwords for users nbgadmin and nbguser manually"
echo "usermod --password \$(openssl passwd -1 <PSW>) <USR>"
echo ""
