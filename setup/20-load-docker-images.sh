#! /bin/sh
source ../common.sh

b_log "Pre-loading required docker images."

PARALLEL_JOBS=4

cat cached-images | xargs -P $PARALLEL_JOBS -n1 -I '{}' sh -c 'echo "Started loading {}"; kind load docker-image {} > /dev/null; echo "Finished loading {}"'