
#! /bin/sh
source ../common.sh

b_log "Creating cluster"

kind create cluster --config ../_10-create-cluster/kind-config.yaml

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

s_log "K8s cluster created kubernetes configuration set to $KUBECONFIG"

b_log "Pre-loading required docker images."

cat cached-images | xargs -P2 -n1 -I '{}' sh -c 'echo "Started loading {}"; kind load docker-image {} > /dev/null; echo "Finished loading {}"'
