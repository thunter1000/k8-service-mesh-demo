#! /bin/sh

source ../common.sh

b_log "Removing docker images"

cat cached-images | xargs -P10 -n1 -I '{}' sh -c 'echo "Started removing {}"; docker image rm {} > /dev/null; echo "Finished removing {}"'

s_log "Docker images removed"