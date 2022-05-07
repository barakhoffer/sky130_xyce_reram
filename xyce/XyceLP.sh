#!/bin/bash
SCRIPT=$(readlink -f "$0")
search_dir=$(dirname "$SCRIPT")
PARAMS=""
for entry in $(realpath $search_dir/../lib/plugins)/*.so
do
  if [ -f "$entry" ]
  then
  PARAMS+=" -plugin $entry"
  fi
done
$search_dir/Xyce "$@"$PARAMS
