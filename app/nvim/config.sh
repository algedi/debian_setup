#! /bin/bash

rm -rf $HOME/.config/nvim
rm -rf $HOME/.cache/nvim
rm -rf $HOME/.local/share/nvim
rm -rf $HOME/.local/state/nvim
mkdir -p $HOME/.config/nvim
git clone https://gitlab.com/kui.team/nvim_lazy_setup.git $HOME/.config/nvim
