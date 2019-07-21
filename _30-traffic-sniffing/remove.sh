#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

if [ $(kubectl get ns -o 'jsonpath={..name}' | tr ' ' '\n' | grep ^traffic-sniffing$ | wc -l) -gt 0 ]
then
  b_log "Removing traffic sniffing namespace."
  (
    show_cmds
    kubectl delete ns --now traffic-sniffing || true
  )
  s_log "Traffic sniffing demo has been removed from the cluster."
fi

if [ $(docker image ls traffic-sniffing-container -q | wc -l) -gt 0 ]
then
  b_log "Deleting docker image"
  (
      docker image rm -f traffic-sniffing-container
  )
  s_log "Docker image deleted"
fi