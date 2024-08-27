#! /bin/bash

sApp="tmux"
case $1 in
--config) ;;
--ver)
  if command -v $sApp &>/dev/null; then
    echo -e "$($sApp -V | awk 'NR==1 {print $2}')"
    # echo -e $("git -v")
  fi
  ;;
*)
  if command -v $sApp &>/dev/null; then
    echo "$sApp"
  fi
  ;;
esac
