#!/bin/sh
source ../common.sh

b_log "Creating cluster"

kind create cluster --config kind-config.yaml || {
  echo "Failed to create cluster"
  exit 1
}

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

s_log "K8s cluster created kubernetes configuration set to $KUBECONFIG"
