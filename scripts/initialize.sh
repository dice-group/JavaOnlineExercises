#!/bin/bash

# This file creates 3 example students and copies example notebooks



# Configuration

CONTAINER_NAME="nbgjava"



# Ensure correct working directory

cd "$(dirname "$0")"



# If container.txt exists, the including container name will be used.

if [ -e container.txt ]
then
    CONTAINER_NAME=`cat container.txt`
fi



# Create example students: nbgtesta, nbgtestb, nbgtestc

./create-students.sh ../examples/teststudents.ENCRYPTED.csv



# Create example notebooks

docker cp ../examples/AssignmentAdministration.ipynb "$CONTAINER_NAME":/home/nbgadmin/

docker exec $CONTAINER_NAME mkdir /home/nbgadmin/templates
docker cp ../examples/AssignmentTemplate.ipynb "$CONTAINER_NAME":/home/nbgadmin/templates/
docker cp ../examples/FilesystemExample.ipynb "$CONTAINER_NAME":/home/nbgadmin/templates/
docker cp ../examples/MultipleChoiceExample.ipynb "$CONTAINER_NAME":/home/nbgadmin/templates/

docker exec $CONTAINER_NAME mkdir /home/nbgadmin/tests
docker cp ../examples/TestTime.ipynb "$CONTAINER_NAME":/home/nbgadmin/tests/
docker cp ../examples/TestFilesystem.ipynb "$CONTAINER_NAME":/home/nbgadmin/tests/

docker exec $CONTAINER_NAME mkdir /home/nbguser/tests
docker cp ../examples/TestFilesystem.ipynb "$CONTAINER_NAME":/home/nbguser/tests/

docker exec $CONTAINER_NAME chown -R nbgadmin:nbgadmin /home/nbgadmin/
