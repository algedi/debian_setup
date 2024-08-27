#! /bin/bash

clear

echo "*****************************"
echo "*    INSTALLAZIONE          *"
echo "*****************************"

find "$PWD/app" -maxdepth 1 -type d | while read dir; do
  sApp=$(basename "$dir")
  if [ "$sApp" != "." ] && [ "$sApp" != "app" ]; then
    echo
    echo "***************************************************"
    echo "   $sApp                                           "
    echo "***************************************************"
    sPath="$PWD/app/$sApp"
    if [ -f $sPath/install.sh ]; then
      if [ -z $($sPath/check.sh) ]; then
        eval $sPath/install.sh
      else
        echo "GIA' INSTALLATO"
      fi
    fi
    if [ -f $sPath/config.sh ]; then
      if [ -z $($sPath/check.sh --config) ]; then
        eval $sPath/config.sh
      else
        echo "GIA' CONFIGURATO"
      fi
    fi
  fi
done

sleep 5
clear

echo -e "APP\t\t\t\tver.\t\t\t\tconf"
echo
find "./app" -maxdepth 1 -type d | while read dir; do
  sApp=$(basename "$dir")
  if [ "$sApp" != "." ] && [ "$sApp" != "app" ]; then
    sCheck="./app/$sApp/check.sh"
    if [ -f $sCheck ]; then
      echo -e "$($sCheck)\t\t\t\t$($sCheck --ver)\t\t\t\t$($sCheck --config)"
    fi
  fi
done
echo
echo
