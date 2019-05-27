#! /bin/sh
source ../common.sh

b_log "Deleting the cluster for the demo"
kind delete cluster
s_log "Cluster deleted"