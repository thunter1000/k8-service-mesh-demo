#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

b_log "Building docker image for dumping tcp traffic."
(
  show_cmds
  docker build -t attacker-container $script_dir
)
s_log "Attacker container built with the tag attacker-container:latest"