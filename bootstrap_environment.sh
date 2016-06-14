#!/bin/bash

oh-my-zsh_dir=~/.oh-my-zsh
plugins_dir=~/.oh-my-zsh/custom/plugins
themes_dir=~/.oh-my-zsh/custom/themes

# install oh-my-zsh if not already
if [ ! -d "$oh-my-zsh_dir" ]; then
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

if [ ! -d "$plugins_dir" ]; then
    mkdir -p "$plugins_dir"
fi

git clone https://github.com/zsh-users/zsh-completions.git $plugins_dir/.
git clone https://github.com/zsh-users/zsh-history-substring-search.git $plugins_dir/.
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugins_dir/.

if [ ! -d "$themes_dir" ]; then
    mkdir -p "$themes_dir"
fi

