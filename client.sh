#!/bin/bash
# Client for distributed tor and bitcoin vanity address generation
# Copyright 2017 Kevin Froman (https://ChaosWebs.net/) MIT License
####Config Area###

clientID="m1"

server="http://192.168.1.101:2015/distgen/"

checkTimeout=1
##################

weFound="true" # if this machine found it or not

while [ 1 ]
do
    type=$(curl -s "$server/distgen.php?cmd=type")

    string=$(curl -s "$server/distgen.php?cmd=string")

    if [ "$type" = "" ]; then
        exit 0
    fi

    if [ "$string" = "" ]; then
        echo "No string given"
        exit 0
    fi

    if [ "$type" = "onion" ]; then
        shallot $string >> address.txt &
    elif [ "$type" = "bitcoin" ]; then
        vanitygen $string >> address.txt &
    fi
    pid=$!
    while [ 1 ]
    do
    if [ -e /proc/$pid ]; then
        sleep $checkTimeout
        if [ $(curl -s "$server/distgen.php?cmd=check") = "false" ]; then
            echo "Another machine found it"
            kill $pid
            weFound="false"
            break
        fi
    else
        break
    fi
    done
    if [ "$weFound" = "true" ]; then
        if [ $? = 0 ]; then
            echo "success, reporting back to server"
            curl "$server/distgen.php?cmd=success&clientID=$clientID" >/dev/null
        else
            echo "Failure, reporting back to server"
            curl "$server/distgen.php?cmd=failure&clientID=$clientID" >/dev/null
        fi
   fi
done
