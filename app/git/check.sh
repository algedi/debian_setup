#! /bin/bash

case $1 in
--config)
  sVer=$(git config --get-all alias.co)
  if [[ "$sVer" == "commit -a -m" ]]; then
    echo "kui.setup"
  fi
  ;;
--ver)
  if command -v git &>/dev/null; then
    echo -e "$(git -v | awk 'NR==1 {print $3}')"
    # echo -e $("git -v")
  fi
  ;;
*)
  if command -v git &>/dev/null; then
    echo "git"
  fi
  ;;
esac
