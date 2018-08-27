#!/bin/bash

# This file executes a command to access a bash inside a docker container.

CONTAINER_NAME="diceapp"

docker exec --interactive --tty $CONTAINER_NAME /bin/bash
