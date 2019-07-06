
#! /bin/sh
source ../common.sh

b_log "Creating cluster"

kind create cluster --config ../_10-create-cluster/kind-config.yaml

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

s_log "K8s cluster created kubernetes configuration set to $KUBECONFIG"
