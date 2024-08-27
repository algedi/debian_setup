#! /bin/bash

if [ ! -f $HOME/.config/ranger/rifle.conf ]; then
  mkdir $HOME/.config/ranger/
  cp $PWD/app/ranger/file/rifle.conf $HOME/.config/ranger/rifle.conf
fi
