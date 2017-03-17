#!/bin/bash
# Client for distributed tor and bitcoin vanity address generation

function encrypt {

if [ "$save" = "true" ]; then
    echo "encrypting file"
    #echo "$output"
    echo $output | gpg  -a --passphrase "$password" --symmetric --cipher-algo AES256 >> address.asc
    echo "exit code: $?"
fi

}


type="$1"

string="$2"

crypt="$3"

if [ "$crypt" = "true" ]; then
    echo -n Password:
    read -s password
    echo
fi

if [ "$1" = "" ]; then
    exit 0
fi

if [ "$2" = "" ]; then
    echo "No string given"
    exit 0
fi

if [ "$type" = "onion" ]; then
    output=$(shallot $2)
elif [ "$type" = "bitcoin" ]; then
    output=$(vanitygen $2)
fi

if [ $? = 0 ]; then
    echo "success"
    if [ "$crypt" = "true" ]; then
        encrypt
    fi
    exit 0
else
    echo "Failure :("
    exit 1
fi
