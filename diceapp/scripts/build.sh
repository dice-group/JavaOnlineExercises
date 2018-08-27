#!/bin/bash

# This file builds a docker image based on a dockerfile.

IMAGE_NAME="diceapp"
TAG_NAME="latest"

echo "Monitor the progress with: tail -f -n 20 build.log"
docker build -t $IMAGE_NAME:$TAG_NAME . >> build.log
echo ""
echo "Please set the passwords for users nbgadmin and nbguser manually"
echo "usermod --password \$(openssl passwd -1 <PSW>) <USR>"
echo ""
echo "Ensure existence of configuration file"
echo "mv /tmp/jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py"
echo ""
