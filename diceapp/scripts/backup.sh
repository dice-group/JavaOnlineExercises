#!/bin/bash

# This uses rsync and ssh to create a local backup.
# If an argument is given, it will be used as local path.
# If no argument is given, a subfolder of the current working directory is used.

USER="admin"
DOMAIN="example.cs.upb.de"
DIR_REMOTE="/mnt/diceapp/home/nbgadmin"

if [ $# -eq 1 ]; then
    DIR_LOCAL=$1
else
    DIR_LOCAL=$PWD
    DIR_LOCAL=$DIR_LOCAL$(date +"/%Y-%m-%d_%H-%M-%S/")
fi

rsync -r -e ssh $USER@$DOMAIN:$DIR_REMOTE $DIR_LOCAL
