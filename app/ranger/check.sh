#! /bin/bash

case $1 in
--config)
  if [ -f $HOME/.config/ranger/rifle.conf ]; then
    echo "kui.setup"
  fi
  ;;
--ver)
  if command -v ranger &>/dev/null; then
    echo -e "$(ranger --version | awk 'NR==1 {print $4}')"
  fi
  ;;
*)
  if command -v ranger &>/dev/null; then
    echo "ranger"
  fi
  ;;
esac
