#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

containerTag="traffic-sniffing-container:latest"

b_log "Building docker image."
(
  show_cmds
  docker build -t $containerTag $script_dir
)
s_log "Traffic sniffing container built with the tag $containerTag"