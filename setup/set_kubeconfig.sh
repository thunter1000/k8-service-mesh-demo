#! /bin/sh

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"