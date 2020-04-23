#!/bin/bash

# This file writes in a CSV file.
#
# CSV file line structure:
# user<ID>,user<ID>,user<ID>,
#
# representing:
# user-id,first-name,surname,email@address
#
# example:
# user1,user1,user1,



# Check input parameters

if [ $# -ne 3 ]; then
    echo "generate-users.sh <CSV output file> <first ID> <last ID>"
    echo "Output file line structure: user<ID>,user<ID>,user<ID>,"
    exit 1
fi

FILE=$1
BEGIN=$2
END=$3



# Generate users

for ((i=${BEGIN};i<=${END};i++))
do
   echo "user${i},user${i},user${i}," >> $FILE
done
