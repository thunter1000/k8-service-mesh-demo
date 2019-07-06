#! /bin/sh
source ../common.sh

b_log "Pulling docker images for the demo"

cat cached-images | xargs -P10 -n1 -I '{}' sh -c 'echo "Started pulling {}"; docker image pull {} > /dev/null; echo "Finished pulling {}"'

s_log "Docker images successfuly pulled"