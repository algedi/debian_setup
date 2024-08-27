#! /bin/bash

sApp="nvim"
case $1 in
--config)
  if [[ -d $HOME/.config/nvim ]]; then
    echo "kui.setup"
  fi
  ;;
--ver)
  if command -v $sApp &>/dev/null; then
    echo -e "$($sApp -v | awk 'NR==1 {print $2}')"
    # echo -e $("git -v")
  fi
  ;;
*)
  if command -v $sApp &>/dev/null; then
    echo "$sApp"
  fi
  ;;
esac
