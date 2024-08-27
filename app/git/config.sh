#! /bin/bash

git config --global alias.co 'commit -a -m'
git config --global alias.ck 'checkout'
git config --global alias.br 'branch'
git config --global alias.bra 'branch --all'
git config --global alias.st 'status'
git config --global alias.tool 'vimdiff'
git config --global alias.merge 'vimdiff'
git config --global alias.ls "log --all --decorate --graph --oneline"
git config --global alias.ll 'log --all --graph --pretty=format:"%C(cyan)(%ci) %<(10) %C(green)%cn%Creset %C(yellow)%h /%C(white)%C(bold)%s%C(reset) %C(auto)%d%Creset"'
