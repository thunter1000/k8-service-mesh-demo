#! /bin/sh
source ../common.sh

echo ""
echo "This step isn't required, just makes deploying "
echo "to the cluster faster when demoing. Press "
echo "\"ctrl-c\" to cancel"
echo ""

b_log "Pre-loading required docker images."

PARALLEL_JOBS=4

cat cached-images | xargs -P $PARALLEL_JOBS -n1 -I '{}' sh -c 'echo "Started loading {}"; kind load docker-image {} > /dev/null; echo "Finished loading {}"'