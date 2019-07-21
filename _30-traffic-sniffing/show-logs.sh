#! /bin/sh
script_dir=$(dirname $0)
source $script_dir/../common.sh

(
  show_cmds;
  kubectl -n traffic-sniffing logs deploy/attacker -f
)