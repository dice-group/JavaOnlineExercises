#!/bin/bash

# This file generates a CSV file with users and passwords.

if [ $# -lt 2 ]; then
    echo "generate-users.sh <file> <number> [start]"
    exit 1
fi

FILE=$1
NUMBER=$2
START=1
if [ $# -eq 3 ]; then
    START=$3
fi

for (( I=$START; I<$START+$NUMBER; I++))
do
    U="user$I"
    P="dice"
    P=$P$(< /dev/urandom tr -dc 1-9 | head -c3)
    P=$P$(< /dev/urandom tr -dc a-z | head -c3)
    echo $U,$P >> $1
done
