#!/usr/bin/env bash

# By name
# RUN_USER=user
# RUN_GROUP=public_readwrite
# export RUN_UID=$(id -u $RUN_USER)
# export RUN_GID=$(getent group $RUN_GROUP | cut -d: -f3)

# By ID
export RUN_UID=1000
export RUN_GID=1001

die () {
    echo >&2 "$@"
    exit 1
}

PORT_NR_REGEX='^([1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$'

if [ "-h" = "$1" ] || [ "--help" = "$1" ] || [ "$1" = "" ]; then
    echo "usage: up.sh opl_dir [port]"
    echo "       - opl_dir: The directory in which your games are stored."
    echo "       - port: The port which the server will listen on (445 by default)."
    exit 0
fi


if [ -n $2 ]; then
    echo "$2" | grep --extended-regexp $PORT_NR_REGEX > /dev/null || die "Invalid port number"
    export RUN_PORT=$2
else
    export RUN_PORT=445
fi

if [ -d $1 ]; then
    export RUN_MOUNT=$1
else
    die 'The OPL game directory you passed does not exist.'
fi

#####################################################

echo "UID is $RUN_UID"
echo "GID is $RUN_GID"
echo "PORT is $RUN_PORT"
echo "MOUNT is $RUN_MOUNT"

echo "Starting..."
docker-compose up -d
