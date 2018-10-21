#!/bin/bash

# This file builds a docker image based on a dockerfile.
# The output is written to build.log



# Uncomment for disabling script (as it has to be executed only one time)

#echo "Script disabled." ; exit



# Configuration

IMAGE_NAME="nbgjava"
TAG_NAME="latest"



# Ensure correct working directory

cd "$(dirname "$0")"



# Execution

echo "Monitor the progress with: tail -f -n 20 build.log"
docker build -t $IMAGE_NAME:$TAG_NAME . >> build.log
