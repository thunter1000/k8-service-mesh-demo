
#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Creating cluster"

kind create cluster --config $script_dir/kind-config.yaml

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"

s_log "K8s cluster created kubernetes configuration set to $KUBECONFIG"
