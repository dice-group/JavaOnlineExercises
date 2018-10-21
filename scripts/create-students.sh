#!/bin/bash

# This file reads a CSV file and adds student accounts to a docker container.
# It uses the script create-student.sh.
#
# CSV file line structure:
# studentId,encryptedPa$$word,first name(s),the surname(s),email@address



# Ensure correct working directory

cd "$(dirname "$0")"



# Check input parameters

if [ $# -ne 1 ]; then
    echo "create-students.sh <CSV file>"
    echo "Input file line structure: studentId,encryptedPa\$\$word,first name(s),the surname(s),email@address"
    exit 1
fi

FILE=$1

if [ -r $FILE ];then
    echo "Reading: $FILE"
else
    echo "Error: Can not read: $FILE"
    exit 2
fi



# Create students

while IFS=',' read -r ID ENCRYPTED_PASSWORD FIRST_NAME SURNAME EMAIL ; do
    ./create-student.sh "$ID" "$ENCRYPTED_PASSWORD" "$FIRST_NAME" "$SURNAME" "$EMAIL"
done < "$FILE"
