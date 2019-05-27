#! /bin/sh
source ../common.sh

b_log "Pre-loading required docker images."

cat cached-images | xargs -P2 -n1 -I '{}' sh -c 'echo "Started loading {}"; kind load docker-image {} > /dev/null; echo "Finished loading {}"'