#! /bin/bash

sApp="npm"
case $1 in
--config) ;;
--ver)
  if command -v $sApp &>/dev/null; then
    echo -e "$($sApp -v | awk 'NR==1 {print $1}')"
    # echo -e $("git -v")
  fi
  ;;
*)
  if command -v $sApp &>/dev/null; then
    echo "$sApp"
  fi
  ;;
esac
