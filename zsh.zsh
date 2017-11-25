tangle () {
    FILE=$(realpath $1)
    open -a /usr/local/Cellar/emacs/25.2/Emacs.app --args --eval "(progn
        (require 'org)
        (find-file (expand-file-name \"$FILE\"))
        (org-babel-tangle))"
}

old () {
    rm ~/.zshrc
    ln -s ~dotfiles/zshrc.zsh ~/.zshrc
}

new () {
    rm ~/.zshrc
    ln -s ~dotfiles/zsh.zsh ~/.zshrc
}

# Try to correct the spelling of all arguments in a line.
unsetopt correct_all
# Try to correct the spelling of commands.
setopt correct
# Remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE

export HOME=/Users/mbayer
# projects
hash -d ai=$HOME/Workspace/ai
hash -d amber=$HOME/Workspace/amber
hash -d bay=$HOME/Workspace/bay
hash -d gists=$HOME/Workspace/gists
hash -d hackedHN=$HOME/Workspace/hackedHN
hash -d impure=$HOME/Workspace/impure
# system
hash -d bin=$HOME/bin
hash -d desktop=$HOME/Desktop
hash -d dev=$HOME/Workspace
hash -d documents=$HOME/Documents
hash -d dotfiles=$HOME/Settings/dotfiles
hash -d downloads=$HOME/Downloads
hash -d dropbox=$HOME/Dropbox
hash -d emacs.d=$HOME/.emacs.d
hash -d library=$HOME/Library
hash -d music=$HOME/Music
hash -d oh-my-zsh=$HOME/.oh-my-zsh
hash -d org=$HOME/Documents/org
hash -d pictures=$HOME/Pictures
hash -d regiobot=$HOME/Workspace/project-inquant/gitlab
hash -d rezepte=$HOME/Documents/org/rezepte
hash -d scripts=$HOME/Workspace/scripts
hash -d settings=$HOME/Settings
hash -d tmp=$HOME/tmp
hash -d trash=$HOME/.Trash
hash -d utils=$HOME/utils
hash -d videos=$HOME/Movies
# mounts
hash -d i32=/Volumes/INGOT32
hash -d i64=/Volumes/INGOT64
hash -d sd2=/Volumes/sd2
hash -d sd=/Volumes/sd
hash -d v=/Volumes
# mobile
hash -d mobile_audiobooks=root@192.168.178.41:/storage/extSdCard/Audiobooks
hash -d mobile_images=root@192.168.178.41:/storage/extSdCard/DCIM
hash -d mobile_org=root@192.168.178.41:/storage/sdcard0/org_m
hash -d mobile_sd=root@192.168.178.41:/storage/extSDCard
hash -d mobile_storage=root@192.168.178.41:/storage/sdcard0
# files
hash -d emacsrc=$HOME/Settings/dotfiles/emacsrc.org
hash -d vimrc=$HOME/Settings/dotfiles/vimrc.vim
hash -d zsh_history=$HOME/.zsh_history
hash -d zshrc=$HOME/Settings/dotfiles/zshrc.zsh

# PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$PATH"
export BIN=/usr/local/bin
export LANG=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8

# TODO Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="$BIN/vim"
else
    export EDITOR="$HOME/Workspace/scripts/start_emacs.sh"
    # TODO rm obsolete
    export EDITOR_TAB=${EDITOR}
    export VIM_EDITOR="$BIN/mvim"
    export VIM_EDITOR_TAB="${VIM_EDITOR} --remote-tab-silent"
fi

# project amber
export DJANGO_SETTINGS_MODULE=amber.settings

# imagemagick
export MAGICK_HOME="$HOME/bin/ImageMagick-7.0.3"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"
