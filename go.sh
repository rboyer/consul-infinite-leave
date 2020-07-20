#!/bin/sh

unset CDPATH

cd "$(dirname "$0")"


echo "ensure you are running 'docker-compose -f logs' in another window"

set -x

# first we bring everything up if this is the FIRST time running
# this script
docker-compose up -d

# get the first leave message propagating
docker-compose stop client1

# bring our node back briefly to leave again
docker-compose up -d
docker-compose stop client1

# and in case that didn't do it, inject another manual force (non-prune) leave
docker-compose exec server1 consul force-leave client1-node
