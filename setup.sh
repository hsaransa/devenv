#!/bin/bash

set -e -x

mkdir -p ~/tmp
mkdir -p ~/.vim/bundle

rm -fr ~/.vim/bundle/Vundle.vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "source `pwd`/vimrc" > ~/.vimrc
echo "source `pwd`/vimrc" > ~/.nvimrc

vim +PluginInstall +qall

pushd .
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --racer-completer --js-completer
popd

echo "source-file `pwd`/tmux.conf" > ~/.tmux.conf
