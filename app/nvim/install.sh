#! /bin/bash

sPath=$(pwd)
cd /opt
rm -r nvim-linux64
rm /usr/bin/nvim
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
cd $sPath
