#!/bin/bash

# This file reads a CSV file and creates CSV files with (un-)encrypted passwords.
#
# CSV input file line structure:
# studentId, first name(s), the surname(s), email@address
#
# CSV output file line structure:
# studentId, password, first name(s), the surname(s), email@address



# Check input parameters

if [ $# -ne 1 ]; then
    echo "generate-passwords.sh <CSV file>"
    echo "Creates CSV files with passwords"
    echo "Input file line structure: studentId, first name(s), the surname(s), email@address"
    exit 1
fi

FILE=$1



# Create output file names

FILE_ID=$(basename -- "$FILE")
FILE_EXTENSION="${FILE##*.}"
FILE_PASSWORDS="${FILE_ID%.*}.PASSWORDS.$FILE_EXTENSION"
FILE_ENCRYPTED="${FILE_ID%.*}.ENCRYPTED.$FILE_EXTENSION"



# Create passwords and files

while IFS=',' read -r ID FIRST_NAME SURNAME EMAIL || [[ -n "$LINE" ]]; do

    # Create password
    PASSWORD="dice"
    PASSWORD=$PASSWORD$(< /dev/urandom tr -dc 1-9 | head -c4)
    PASSWORD=$PASSWORD$(< /dev/urandom tr -dc a-z | head -c4)
    ENCRYPTED_PASSWORD=$(openssl passwd -1 $PASSWORD)
    ESCAPED_PASSWORD="${ENCRYPTED_PASSWORD//\$/\\\$}"

    # Write password file
    echo $ID,$PASSWORD,$FIRST_NAME,$SURNAME,$EMAIL >> $FILE_PASSWORDS
    echo $ID,$ESCAPED_PASSWORD,$FIRST_NAME,$SURNAME,$EMAIL >> $FILE_ENCRYPTED

done < "$FILE"
