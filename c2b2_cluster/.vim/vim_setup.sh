#!/bin/bash
#By: J.He
#TODO: 

mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd ~/.vim/bundle
git clone git://github.com/tpope/vim-sensible.git

git clone git://github.com/vim-scripts/ctags.vim
git clone git://github.com/vim-scripts/taglist.vim

