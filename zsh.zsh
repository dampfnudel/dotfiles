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

# https://www.iterm2.com/documentation-shell-integration.html
# source ~dotfiles/zsh/iterm2_shell_integration/iterm2_shell_integration.zsh

# allow to change to a directory by entering it as a command
setopt auto_cd
# prevent > redirection from truncating the given file if it already exists
setopt no_clobber
# recognize comments
setopt interactivecomments

## correction
# automatically correct the spelling of each word on the command line
setopt correct_all
# try to correct the spelling of commands.
setopt correct

## history
# zsh sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file
setopt append_history
# works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits
setopt inc_append_history
# save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
setopt extended_history
# the oldest history event that has a duplicate will be lost before losing a unique event from the list
setopt hist_expire_dups_first
# ignore duplication command history list
setopt hist_ignore_dups
# remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_space
# whenever the user enters a line with history expansion, don’t execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
setopt hist_verify
# use the same history file for all sessions
setopt share_history

## completion
# do not autoselect the first completion entry
unsetopt menu_complete
# show completion menu on successive tab press
setopt auto_menu
# if unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
setopt complete_in_word
# if a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word. That is, the cursor is moved to the end of the word if either a single match is inserted or menu completion is performed.
setopt always_to_end

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
hash -d dev=$HOME/dev
hash -d documents=$HOME/Documents
hash -d dotfiles=$HOME/dotfiles
hash -d downloads=$HOME/Downloads
hash -d dropbox=$HOME/Dropbox
hash -d emacs.d=$HOME/.emacs.d
hash -d library=$HOME/Library
hash -d music=$HOME/Music
hash -d oh-my-zsh=$HOME/.oh-my-zsh
hash -d org=$HOME/Documents/org
hash -d pictures=$HOME/Pictures
hash -d screenshots=~pictures/Screenshots
hash -d regiobot=$HOME/Workspace/project-inquant/gitlab
hash -d rezepte=$HOME/Documents/org/rezepte
hash -d scripts=$HOME/Workspace/scripts
hash -d scripts=$HOME/dev/scripts
hash -d settings=$HOME/Settings
hash -d tmp=$HOME/tmp
hash -d trash=$HOME/.Trash
hash -d utils=$HOME/utils
hash -d videos=$HOME/Movies
hash -d tedas=~dev/tedas/vueclient/
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

# $PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$PATH"

# node.js
NPM_PACKAGES="~/.node_modules"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


# paths
# TODO hash?
export BIN=/usr/local/bin
export DOTFILES="$HOME/dotfiles"

# language
export LANG=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8

export TC=Europe/Berlin

# history
# TODO rm 2
export HISTFILE="$HOME/.zsh_history2"
export HISTSIZE=1200000
export SAVEHIST=1000000

# $EDITOR
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="$BIN/vim"
else
    export EDITOR='open -a "Emacs"'
    # TODO rm obsolete
    export EDITOR_TAB=${EDITOR}
    export VIM_EDITOR="$BIN/mvim"
    # TODO function || alias
    export VIM_EDITOR_TAB="${VIM_EDITOR} --remote-tab-silent"
fi

# A list of non-alphanumeric characters considered part of a word by the line editor.
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>/'

# $LS_COLORS
# TODO
eval `gdircolors <(python ~dev/base16/templates/base16-gnu-dircolors/scripts/dircolors)`
# used by k
# export LSCOLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LSCOLORS='exfxcxdxbxegedabagacad'

# project amber
export DJANGO_SETTINGS_MODULE=amber.settings

# PGP
GPG_TTY=$(tty)
export GPG_TTY

# initialize the completion system
autoload -U compinit && compinit
# enable menu widget
# zstyle ':completion*:default' menu 'select=1'
zstyle ':completion:*' menu select
# use dircolors in completion listings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# color options red, descriptions green
zstyle ':completion:*:options' list-colors '=(#b)*(-- *)=31=32'
zstyle ':completion:*:common-commands' list-colors '=(#b)*(-- *)=31=32'
# print the completion type
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format 'Completing %B%d%b'
# TODO style
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
# group different completion types
zstyle ':completion:*' group-name ''
# error can be a transposed character, a missing character or an additional character
# to have a better heuristic, by allowing one error per 6 character typed
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/6 )) numeric )'
# case insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# caching
zstyle ':completion:*' use-cache on
# TODO required?
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
# ignore completion functions for commands you don’t have:
zstyle ':completion:*:functions' ignored-patterns '_*'
# don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
    clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
    gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
    ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
    operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
    usbmux uucp vcsa wwwrun xfs '_*'
# don't complete uninteresting files
zstyle ':completion:*:emacs:*' ignored-patterns '*.(o|a|so|aux|dvi|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
# avoid getting offered the same filename with rm
zstyle ':completion:*:rm:*' ignore-line yes

export WORKON_HOME=~dev/Envs
export PROJECT_HOME=~dev
export VIRTUALENVWRAPPER_PYTHON="$WORKON_HOME/python3.6/bin/python"
source "$BIN/virtualenvwrapper.sh"

# set default virtual_env
export VIRTUALENV_DEFAULT_PATH="$WORKON_HOME/python3.6/bin/activate"
# load it
if [[ $(basename "$VIRTUAL_ENV") == "" ]]
then
    if [[ -f "$VIRTUALENV_DEFAULT_PATH" ]]; then
        source "$VIRTUALENV_DEFAULT_PATH"
    fi
fi

# TODO section for overriding
## list
# use gnu ls for dircolors
alias _ls='gls --color=auto'
# list details
alias _ll='ls -lah'
# sort by size
alias lss='ls -lahS'
# sort by date
alias lsd='ls -latr'
# only today
alias lst='find . -maxdepth 1 -type f -mtime 1'
# numFiles: number of (non-hidden) files in current directory
alias lsc='echo $(ls -1 | wc -l)'
alias k='k -h'     # human readable sizes
# disk usage statistics default (-h(uman readanle))
alias du="du -ach | sort -h"
# free diskspace with human readable size
alias df='df -h'
# stat with human readable times
alias stat='stat -x'

## tools
# emacs
alias e="eval $EDITOR"
alias magit='emacsclient -n -e \(magit-status\)'

# vim
alias cvim='/usr/local/bin/vim'
# create parent directories on demand
alias mkdir="mkdir -pv"

alias ll='exa --long --header --all --group-directories-first --git --colour-scale'
alias ls='exa --group-directories-first --git --colour-scale'
alias lsg='exa --group-directories-first --git --colour-scale'
alias tree='exa --tree'
alias cat='bat'
# clipboard
alias p='pbpaste'
alias y='pbcopy'

alias bpython='$WORKON_HOME/python3.4.1/bin/bpython'
alias grep='grep --color'
## internet
# continue the download in case of problems
alias wget="wget -c"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias chrome_headless='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless --disable-gpu'
alias yt3='$WORKON_HOME/python3.4.1/bin/youtube-dl --verbose --extract-audio --audio-format mp3 --no-mtime --no-cache-dir'
alias yt='$WORKON_HOME/python3.4.1/bin/youtube-dl --no-mtime --no-cache-dir'
# weather
alias wttr='curl -s http://wttr.in | tail +8 | head -30'
# moonphase
alias moon='curl -s wttr.in/Moon|head -25'

# git
alias gs='git status'
alias gc='git commit -m'
alias gd='git diff --color | diff-so-fancy'
alias ga='git add'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias gll='git log --name-status HEAD^..HEAD' # last commit
alias gco='git checkout'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gmd='git merge develop'
alias gu='gitup open .'

alias git_undo_last_local_commit='git reset HEAD~'
alias git_push_fire='git add -A && git commit -a --allow-empty-message -m "" && git push'
alias git_undo_commit='git reset --soft HEAD~'

## actions
alias s='source ~zshrc'
# TODO as functions
# TODO internal/external
alias print_ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
# substitute windows linebreak with unix linebreak
alias fix_linebreaks="/usr/bin/perl -i -pe's/\r$//'"
alias pip_update_all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

alias osx_show_hidden='defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder'
alias osx_hide_hidden='defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder'
alias osx_empty_trash="rm -rf ~/.Trash/."
alias fix_carriage_return="tr '\r' '\n' <"

## cleanup
# TODO as functions
# rm_DS_Store_files: removes all .DS_Store file from the current dir and below
alias rm_ds_store='find . -name .DS_Store -exec rm {} \;'
alias rm_pyc_files='find . -name "*.pyc" -exec rm {} \;'
alias rm_svn_files='find . -type d -name .svn -exec rm -rf {} \;'
alias rm_emacs_files="find . -maxdepth 1 -type f -name '#*#' -exec rm {}\;"

## redirection
# redirect stdout, stderr
alias -g _no_output='> /dev/null 2>&1'
# redirect stderr
alias -g _no_stderr='2> /dev/null'
# redirect stdout
alias -g _no_stdout='&> /dev/null'

## tools
alias -g _vim="| eval ${EDITOR_TAB}"
alias -g _y='| pbcopy'

## files
# alias -g PASS='<(ypcat passwd)'
alias -g _brew='<(brew list)'
alias -g _pip='<(pip freeze)'
alias -g _gem='<(gem list | tail -n +1)'
#  ¯\_(ツ)_/¯
alias -g _npm="<(npm list -g --depth=0 2> /dev/null |cut -c5- | tail -n +2 | sed \$d)"
# TODO function wrapper
alias -g _shrugf='<(echo "¯\\_(ツ)_/¯")'

## variables
alias -g _shrugv='${$(echo "¯\\_(ツ)_/¯")}'

## filter
alias -g _newlines="|sed 's/\\n/\
/g'"

# filter columns
alias -g _awk1="|awk '{print \$1}'"
alias -g _awk2="|awk '{print \$2}'"
alias -g _awk3="|awk '{print \$3}'"
alias -g _awk4="|awk '{print \$4}'"
alias -g _awk5="|awk '{print \$5}'"
alias -g _awk6="|awk '{print \$6}'"
# filter with fzf
alias -g _f="|fzf"
# pager
alias -g _l="|less"
# count lines
alias -g _cl='|wc -l'
alias -g _lc='_cl'
# archives in pwd
alias -g _acd='./(*.bz2|*.gz|*.tgz|*.zip|*.z)'
## map
# funky
alias -g _x='| xargs'
alias -g map='_x'
## github
alias -g _gh='https://github.com/'

# TODO
# open org-mode files in emacs
alias -s org=emacs
# TODO Glob
alias -s jpg=imgcat
alias -s png=imgcat

# called on every cd
chpwd () {
    # put the current directory in the title/tab bar
    # -P option treat its arguments like a prompt string; otherwise the %~ would not be expanded. -n suppresses the terminating newline
    print -Pn "\e]1;%~\a"
}

function __expect () {
    # check if the expected arg amount $1 matches the passed arg amount $2
    # usage:
    # __expect 1 "$#" || return 1
    # TODO get args implicit from last command
    local params_expected params_given
    arguments_expected="$1"
    arguments_given="$2"
    if [[ "$arguments_expected" == "$arguments_given" ]]
    then
        return 0
    # TODO handle
    elif [[ "$arguments_expected" < "$arguments_given" ]]
    then
        return 0
    else
        echo "$arguments_expected arguments required"
        return 1
    fi
}

# TODO rm
# example fzf completion https://github.com/junegunn/fzf/wiki/Examples-(completion)
# Custom fuzzy completion for "doge" command
#   e.g. doge **<TAB>
_fzf_complete_doge() {
  _fzf_complete "--multi --reverse" "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}

# tab completion for the output of the previous command {
_prev_result () {
    local hstring
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}

zle -C prev-comp menu-complete _prev_result
# usage
# $ find . -name "settings.py.*"
# $ vim <Escape>e<Tab>
bindkey '\ee' prev-comp
# }

# fzf filter for the output of the previous command {
fzf_filter_prev () {
    local selection
    selection=$(fc -e - | fzf)
    if [[ -a $selection ]]
    then
        smart_open $selection
    fi
}

zle -N fzf_filter_prev
# usage
# $ ls
# $ <Escape>f
bindkey -s '\ef' 'fzf_filter_prev\n'
# }

# open last output {
open_prev () {
    local files
    files=$(fc -e -)
    if [[ -a $files ]]
    then
        smart_open $files
    fi
}

zle -N open_prev
# usage
# $ ls
# $ <Escape>o
bindkey -s '\eo' 'open_prev\n'
# }

# copy the output of the previous command to clipboard {
copy_prev () {
    fc -e - | pbcopy
}

zle -N cp_prev
# usage
# $ ls
# $ <Escape>c
bindkey -s '\ec' 'cp_prev\n'
# }

# tab completion for git status files {
_git_status_files () {
    local files
    files=$(git status --porcelain | awk '{print $2 }')
    # sleep?
    sleep 1
    set -A flist ${(@s/
/)files}
    compadd - ${flist}
}

zle -C git-files menu-complete _git_status_files
# usage
# $ git add <Escape>g<Tab>
bindkey '\eg' git-files
# }

function get_shell_integration () {
    # https://www.iterm2.com/documentation-shell-integration.html
    curl -L https://iterm2.com/shell_integration/zsh \
    -o ~dotfiles/zsh/iterm2_shell_integration/iterm2_shell_integration.zsh
}

function iterm_rename_tab () {
    echo -ne "\033]0;"$@"\007"
}

function iterm_set_tabcolor {
    case $1 in
        green)
        echo -e "\033]6;1;bg;red;brightness;57\a"
        echo -e "\033]6;1;bg;green;brightness;197\a"
        echo -e "\033]6;1;bg;blue;brightness;77\a"
        ;;
    red)
        echo -e "\033]6;1;bg;red;brightness;270\a"
        echo -e "\033]6;1;bg;green;brightness;60\a"
        echo -e "\033]6;1;bg;blue;brightness;83\a"
        ;;
    orange)
        echo -e "\033]6;1;bg;red;brightness;227\a"
        echo -e "\033]6;1;bg;green;brightness;143\a"
        echo -e "\033]6;1;bg;blue;brightness;10\a"
        ;;
    esac
}

function bip() {
    # Install (one or multiple) selected application(s)
    # using "brew search" as source input
    # mnemonic [B]rew [I]nstall [P]lugin
    local inst=$(brew search | fzf -m)

    if [[ $inst ]]; then
      for prog in $(echo $inst);
      do; brew install $prog; done;
    fi
}

function bup() {
    # Update (one or multiple) selected application(s)
    # mnemonic [B]rew [U]pdate [P]lugin
    local upd=$(brew leaves | fzf -m)

    if [[ $upd ]]; then
      for prog in $(echo $upd);
      do; brew upgrade $prog; done;
    fi
}
function bcp() {
    # Delete (one or multiple) selected application(s)
    # mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
    local uninst=$(brew leaves | fzf -m)

    if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
    fi
}

function chrome_history () {
    # browse chrome history
    local cols sep entry
    cols=$(( COLUMNS / 3 ))
    sep='{{::}}'

    # Copy History DB to circumvent the lock
    # - See http://stackoverflow.com/questions/8936878 for the file path
    cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

    entry=$(sqlite3 -separator $sep /tmp/h \
        "select substr(title, 1, $cols), url
        from urls order by last_visit_time desc" |
    awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' |
    fzf --ansi --multi | sed 's#.*\(https*://\)#\1#')
    echo "$entry"
    open "$entry"
}

function chrome_print_tabs () {
    # list the opened tabs in google chrome
    osascript -e 'set text item delimiters to linefeed' -e'tell app "google chrome" to url of tabs of window 1 as text' | tail -n +1

}

function firefox_print_tabs () {
    # list the opened tabs in Firefox
    osascript -e '
    tell application "Firefox" to activate
		tell application "System Events"
			keystroke "l" using command down
			keystroke "c" using command down
		end tell
		delay 0.5
		return the clipboard
    end tell'

}

function cat_links () {
    # extract the links from a given url
    __expect 1 "$#" || return 1
    curl "$@" | sed -n 's/.*href="\([^"]*\).*/\1/p'
}

function print_external_ip () {
    # print the external ip
    curl ipecho.net/plain
}

function clipboard_plain_text () {
    # convert clipboard content to plain text
    pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy
}

function clipboard_rm_python () {
    # rm ">>> " from clipboard entry
    pbpaste | cut -c 4- | pbcopy
}
function clipboard_json_pp () {
    # requires /usr/bin/json_pp
    pbpaste | json_pp | pbcopy
}
function clipboard_newlines_replace () {
    ## format clipboard
    pbpaste | sed 's/\\n/\
/g' | pbcopy
}

function fdr() {
    # TODO fcd & fcd_up
    # fdr - cd to selected parent directory
    local declare dirs=()
    get_parent_dirs() {
      if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
      if [[ "${1}" == '/' ]]; then
        for _dir in "${dirs[@]}"; do echo $_dir; done
      else
        get_parent_dirs $(dirname "$1")
      fi
    }
    local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
    cd "$DIR"
}

function cat_human_time () {
    # print unix timestamps in human readable form
    __expect 1 "$#" || return 1
    perl -lne 'm#: (\d+):\d+;(.+)# && printf "%s :: %s\n",scalar localtime $1,$2' "$1"
}

function tac () {
    # reverse line order of file
    __expect 1 "$#" || return 1
    sed '1!G;h;$!d' "$@"
}

function print_timestamp () {
    echo $(date +%Y-%m-%d-%H-%M-%S)
}

function print_datestamp () {
    echo $(date +%Y-%m-%d)
}

# TODO fzf
function li () {
    # print the latest file or dir in $1
    local idx dir
    # no params: dir=pwd
    if [ $# -eq 0 ]; then dir="$(pwd)"; else dir="$1" fi
    # no index: index=last
    if [ -z "$2" ]; then idx="1"; else idx="$2"; fi
    (cd "$dir" && realpath "$(ls -1t | head -n$idx | tail -1)")
}

function git_stats_week () {
    git log --shortstat --after="$(date -v Sun)" | grep -E "fil(e|es) changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed: ", files, "lines inserted: ", inserted, "lines deleted: ", deleted }'
}

function git_commitcount () {
    git shortlog -sn
}

function git_branch_unmerged () {
    git branch --no-merged master
}

function git_stats_week () {
    git log --shortstat --after="$(date -v Sun)" | grep -E "fil(e|es) changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed: ", files, "lines inserted: ", inserted, "lines deleted: ", deleted }'
}
function git_commitcount () {
    git shortlog -sn
}
function git_log_week () {
    git log --branches --remotes --tags --oneline --pretty=format:"%Cgreen%cd%Creset - %s%Creset" --abbrev-commit --date=local --date=format:'%d.%m-%Y %H:%M %a' --after="$(date -v Sun)"
}

function git_log_today () {
    git log --branches --remotes --tags --pretty=format:'%Cgreen%cd%Creset - %s%Creset' --abbrev-commit --date=iso|grep $(date "+%Y-%m-%d")|cut -c 27-
}

function git_log_yesterday () {
    git log --branches --remotes --tags --pretty=format:'%Cgreen%cd%Creset - %s%Creset' --abbrev-commit --date=iso|grep $(date -j -v-1d "+%Y-%m-%d")
}

function git_log_group_by () {
    for TICKETNR in "$@"
    do
        echo "$TICKET"
        git log --reverse --since="6am" --oneline --abbrev-commit |cut -c 9- |grep $TICKET |sed 's/'$TICKET'//' |sed 's/.*/- &/'
        echo ""
    done
}

function gru () {
    # print the git remote url
    git config --get remote.origin.url
}

function gbn () {
    # print the git branch name
    git branch|grep "\*"|awk '{print $2}'
}

lscat () {
    # print a separated list of files in dir $1
    local dir
    if [ $# -eq 0 ]; then dir="$(pwd)"; else dir="$1" fi
    find "$dir" -maxdepth 1 -type f -print | while read -r d
    do
        echo ""
        echo "=-=-= $d =-=-="
        echo "------------------------------------------------"
        echo ""
        pygmentize "$d" || cat "$d"
        echo ""
    done
}

count_files () {
    # count files in dir $1
    local dir
    if [ $# -eq 0 ]; then dir="$(pwd)"; else dir="$1" fi
    for d in $(find "$dir" -type d -print);
    do
        files=$(find "$d" -maxdepth 1 -type f | wc -l )
        echo "$d : $files"
    done
}

function list_all_apps () {
    # list all applications on the system
    mdfind 'kMDItemContentTypeTree == "com.apple.application"c'
}

git_commits_today () {
    # list all commits made today, group by regex
    for TICKETNR in "$@"
    do
        echo "$TICKET"
        git log --reverse --since="6am" --oneline --abbrev-commit |cut -c 9- |grep $TICKET |sed 's/'$TICKET'//' |sed 's/.*/- &/'
        echo ""
    done
}

convert_org_to_markdown () {
  [ ! -f "$1" ] && echo "existing file expected" && exit 1

  filename=$(basename -- "$1")
  filename="${filename%.*}"
  outfile="$filename.md"

  pandoc "$1" --atx-headers -f org -t markdown -s -o "$outfile"

  echo "$outfile"
}

git_delete_branch () {
    __expect 1 "$#" || return 1

    # remote
    git push -d origin "$1"
    # local
    git branch -d "$1"
}

function kill_lines_containing () {
    # delete lines containing pattern $1 in file $2
    if [ $# -lt 2 ]; then echo "Usage: kill_lines_containing <PATTERN> <FILE>"; return 1; fi
    sed -i '' "/$1/d" "$2"
}

function ff () {
    # find a file under the current directory
    # rg --files --hidden --follow -g "$@"
    find . -name "$@"
}

function fff () {
    # fuzzy find file under the current directory
    find . -name "*$@*"
}

function ffs () {
    # find a file whose name starts with a given string
    find . -name "$@"'*'
}

function ffe () {
    # find a file whose name ends with a given string
    find . -name '*'"$@"
}

function fd () {
    # find a directory
    find . -type d -name '*'"$@"
}

function ffd () {
    # fuzzy find a directory
    find . -type d -name "*$@*"
}

# git repo
function ffg () {
    # find a file under the current git repo
    find $(git rev-parse --show-toplevel) -name "$@"
}

function ffsg () {
    # find a file whose name starts with a given string within the current git repo
    find $(git rev-parse --show-toplevel) -name "$@"'*'
}

function ffeg () {
    # find a file whose name ends with a given string within the current git repo
    find $(git rev-parse --show-toplevel) -name '*'"$@"
}

function fdg () {
    # find a directory within the current git repo
    find $(git rev-parse --show-toplevel) -type d -name '*'"$@"
}

function rgg () {
    # rg within the git dir
    /usr/local/bin/ag "$@" $(git rev-parse --show-toplevel)
}

## Spotlight
function fs () {
    # find file using Spotlight
    mdfind "kMDItemDisplayName == '$@'wc"
}

function fs_type () {
    # find file by filetype using Spotlight
    # ex: ft video || ft bild || ft pdf
    # c means case insensitive
    mdfind 'kMDItemKind == "*'"$1"'*"c'
}

function fs_recent() {
    # find files created since $1 days using Spotlight
    mdfind -onlyin ~ '(kMDItemContentCreationDate > "$time.today(-'"$1"')") (kMDItemContentCreationDate < ")'
}

function f_word () {
    # lookup words
    grep ^"$@"$ /usr/share/dict/words
}

f_larger () {
    # find files larger than a certain size (in bytes)
    find . -type f -size +${1}c
}

function fli () {
    # (fzf-)filter file in a given directory (sorted by dates)
    __expect 1 "$#" || return 1
    (cd "$1" && realpath "$(ls -1t | fzf)")
}

function append_above () {
    __expect 1 "$#" || return 1
    # like >> but on top instead of below
    # ex: chrome_print_tabs | append_above somefile
    cat - "$1" | sponge "$1"
}

fcd () {
    # fzf cd - cd to selected directory
    local dir
    dir=$(find ${1:-*} -path '/*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf) &&
        realpath "$dir"
    cd "$dir"
}

rg_fzf () {
    # search for file contents; select with fzf
    rg --files-with-matches "$@" | fzf
}

pjson () {
    # pretty print json
    # ex:
    # pjson '{"test": "test"}'
    # pjson myjsonfile.json
    # pjson '{"test": "test"}' myjsonfile.json
    if [ $# -gt 0 ];
    then
        for arg in $@
        do
            if [ -f $arg ];
            then
                less $arg | python -m json.tool
            else
                echo "$arg" | python -m json.tool
            fi
        done
    fi
}

vim () {
    if [ $# -eq 0 ]; then
        # open -a Emacs.app
        eval ${VIM_EDITOR}
        return 0
    fi

    eval ${VIM_EDITOR_TAB} "$@"
}

# TODO as var alias
cd_git_root () {
    # cd to git root
    cd "$(git rev-parse --show-toplevel)"
}

git_status_files () {
    # git status file list
    git status --porcelain | awk '{print $2 }'
}

# TODO as var alias
git_parent_branch () {
    # show which branch the current one is forked from
    local current_branch=`git rev-parse --abbrev-ref HEAD`
    git show-branch -a | ack '\*' | ack -v "$current_branch" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
}

git_tree () {
    # list git tree
    (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null
}

# git push -u origin {BRANCH_NAME}
git_push_branch () {
    git push -u origin "$(git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
}

# show the git log as json
git_log_json () {
    git log --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},'
}
function man () {
# colored man pages
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}


diff_sorted () {
    diff <(sort "$1") <(sort "$2")
}

# TODO shebang
# TODO mkorg, mkgpg
mk_script () {
    # create an executable script
    touch "$1"
    chmod +x "$1"
    eval ${EDITOR} "$1"
}

mkcd () {
    mkdir $1 && cd $_
}

trash () {
    # move file/dir to trash
    mv "$@" "~/.Trash/."
}

bu () {
    # backup the current directory at the parent directoy
    # use encryption with -e
    dname=$(basename $(pwd))
    cd ..
    if [[ "$1" == "-e" ]]; then
        buname=$dname""_$(date +%d%m%y-%H-%M-%S).tar.gz.enc
        tar cz "$dname/" | openssl enc -aes-256-cbc -e > "$buname"
    else
        buname=$dname""_$(date +%d%m%y-%H-%M-%S).tar.gz
        tar czf "$buname" "$dname/"
    fi
    echo "-> ../$buname"
    cd -  >/dev/null 2>&1
}

# lookup dict.cc
de () {
    # translate de -> en
    dict.cc.py de en "$1"
}
# lookup dict.cc for english words
en () {
    # translate en -> de
    dict.cc.py en de "$1"
}

cp_pwd () {
    # copy the current working dir to clipboard
    pwd | pbcopy
}

= () {
    # calculator
    calc="${@//p/+}"
    calc="${calc//x/*}"
    echo "$(($calc))"
}

clock () {
    # show clock
    while sleep 1;
    do
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date;tput rc
    done &
}

explain () {
    # explain tools
    # https://www.mankier.com/blog/explaining-shell-commands-in-the-shell.html
    if [ "$#" -eq 0 ]; then
        while read  -p "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

    alarm () {
        echo "alarm in ""$1""m"

        local secs=$(($1 * 60))
        # display a timer
        while [ $secs -gt 0 ]; do
            # TODO: format minutes
            echo -ne "$secs\033[0K\r"
            sleep 1
            : $((secs--))
        done

        if [[ "$#" > 1 ]]
        then
            say "$2"
        else
            say "alarm, alarm, alarm"
        fi

        # display a notification
        local title="Alarm"
        local subtitle="$1 minutes since"
        local notification="$(date +%d.%m.%Y-%H:%M:%S)"
        local soundname="Hero"

        # TODO make function
        osascript -e "display notification \"$notification\" with title \"$title\" subtitle \"$subtitle\" sound name \"$soundname\""
    }

    eject () {
        # eject all mountable volumes
        osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
    }

    cdf () {
        # change working directory to Finder path
        cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
    }

    toggle_hidden () {
        # toggle show/hide hidden files in finder
        local isVisible=$(defaults read com.apple.finder AppleShowAllFiles)

        # toggle visibility based on variables value
        if [ ${isVisible} = FALSE ]
        then
            defaults write com.apple.finder AppleShowAllFiles TRUE
        else
            defaults write com.apple.finder AppleShowAllFiles FALSE
        fi

        # force changes by restarting Finder
        killall Finder
    }

    zipf () {
        # create a ZIP archive of a file or folder
        zip -r "$1".zip "$1"
    }

    # TODO target
    extract () {
        # extract an archive
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)  tar xjf $1      ;;
                *.tar.gz)   tar xzf $1      ;;
                *.bz2)      bunzip2 $1      ;;
                *.rar)      rar x $1        ;;
                *.gz)       gunzip $1       ;;
                *.tar)      tar xf $1       ;;
                *.tbz2)     tar xjf $1      ;;
                *.tgz)      tar xzf $1      ;;
                *.zip)      unzip $1        ;;
                *.Z)        uncompress $1   ;;
                *)          echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

    # network {
    serve () {
        # serve pwd
        print_ip | awk '{print $1":8000"}'
        # TODO check version
        # python 2
        # python -m SimpleHTTPServer
        python3 -m http.server
    }

    serve_bash () {
        # serve pwd
        print_ip | awk '{print $1":8080"}'
        while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; \
            cat "$1"; } | nc -l 8080; done
    }


    ls_spectrum () {
        # show all 256 colors with color number
        typeset -Ag FX FG BG

        local FX=(
            reset     "%{[00m%}"
            bold      "%{[01m%}" no-bold      "%{[22m%}"
            italic    "%{[03m%}" no-italic    "%{[23m%}"
            underline "%{[04m%}" no-underline "%{[24m%}"
            blink     "%{[05m%}" no-blink     "%{[25m%}"
            reverse   "%{[07m%}" no-reverse   "%{[27m%}"
        )

        for color in {000..255}; do
            FG[$color]="%{[38;5;${color}m%}"
            BG[$color]="%{[48;5;${color}m%}"
        done

        local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

        for code in {000..255}; do
            print -P -- "$code: %F{$code}$ZSH_SPECTRUM_TEXT%f"
        done
    }

    ls_spectrum_bg () {
        # show all 256 colors where the background is set to specific color
        typeset -Ag FX FG BG

        local FX=(
            reset     "%{[00m%}"
            bold      "%{[01m%}" no-bold      "%{[22m%}"
            italic    "%{[03m%}" no-italic    "%{[23m%}"
            underline "%{[04m%}" no-underline "%{[24m%}"
            blink     "%{[05m%}" no-blink     "%{[25m%}"
            reverse   "%{[07m%}" no-reverse   "%{[27m%}"
        )

        for color in {000..255}; do
            FG[$color]="%{[38;5;${color}m%}"
            BG[$color]="%{[48;5;${color}m%}"
        done

        local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
        for code in {000..255}; do
            print -P -- "$BG[$code]$code: $ZSH_SPECTRUM_TEXT %{$reset_color%}"
        done
    }

    nyan () {
        # miau miau miau miau miau
        telnet nyancat.dakko.us
    }

    tron () {
        # wasd movement
        ssh sshtron.zachlatta.com
    }

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# TODO use terminfo
## movement http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Movement
bindkey '^[^[[D' backward-word                      # alt <arrow-left>............move a word backward
bindkey '^[^[[C' forward-word                       # alt <arrow-right>...........move a word forward
bindkey '^A' beginning-of-line                      # cmd <arrow-left>............move to the beginning of the line
bindkey '^E' end-of-line                            # cmd <arrow-right>...........move to the end of the line
# bindkey '^[[1;2B' down-line
# bindkey '^[[1;2A' up-line
bindkey '^N' vi-find-next-char

## Modifying-Text http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Modifying-Text
bindkey '^[[1;6D' copy-prev-word # ctr shift <-

## kill
bindkey '^[^H' backward-kill-word                   # cmd <del>...................delete the word left of the cursor
bindkey '^X' delete-char                            # ctrl x......................delete the char under the cursor
bindkey '^[k' kill-region
bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
    # fixes outputting tildes on <del>
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# eval
bindkey -s '^L' 'ls -laH\n'
bindkey -s '^K' 'cd ..\n'

# menu select
bindkey '^[cks' accept-and-hold
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

## history
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

## mark / region
bindkey '^[^[[B' set-mark-command
bindkey '^[^[[A' deactivate-region

function repeat-cmd () {
    # repeat the last command
    zle up-history
    zle accept-line
}

zle -N repeat-cmd
# ctrl l
bindkey '^H' repeat-cmd

function wrap-call () {
    # wrap the cursor in "$()"
    LBUFFER+="\"\$("
    RBUFFER+=")\""
}

zle -N wrap-call
# esc (
bindkey '^[(' wrap-call

function wrap-var () {
    # wrap the cursor in "${}"
    LBUFFER+="\"\${"
    RBUFFER+="}\""
}

zle -N wrap-var
# esc {
bindkey '^[{' wrap-var

function kill-first-word () {
    # kill the first word on the cmdline and move cursor to beginning of line
    zle beginning-of-line
    zle forward-word
    zle backward-kill-word
    LBUFFER+=' '
    zle backward-word
}

zle -N kill-first-word
# ctrl shift f
bindkey '^[cskf' kill-first-word

function kill-word-under-cursor () {
    # kill the word under the cursor
    zle forward-word
    zle backward-kill-word
}

zle -N kill-word-under-cursor
# ctrl shift w
bindkey '^[cskw' kill-word-under-cursor

function copy-cmdline-to-clipboard () {
    # Copy the current commandline to the system clipboard
    zle kill-whole-line
    print -rn -- $CUTBUFFER | pbcopy
    zle undo
}

zle -N copy-cmdline-to-clipboard
# esc c
bindkey '^[c' copy-cmdline-to-clipboard

function rationalise-dot() {
    # expands .... to ../../..
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

function backward-delete-path-part () {
    # backward delete until /
    # TODO document
    # local WORDCHARS="${WORDCHARS:s#/#}"
    local WORDCHARS="${WORDCHARS//\/}"
    zle backward-delete-word
}
zle -N backward-delete-path-part
bindkey '^W' backward-delete-path-part

# TODO what's this
if [[ $- == *i* ]]; then
    # CTRL-G - Paste the selected dir path(s) into the command line
    __fsel() {
    local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
        -o -type f -print \
        -o -type d -print \
        -o -type l -print 2> /dev/null | sed 1d | cut -b3-"}"
    eval "$cmd" | $(__fzfcmd) -m | while read item; do
        printf '%q ' "$item"
    done
    echo
    }

    __fsel-dir() {
    local cmd="${FZF_ALT_C_COMMAND:-"command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
        -o -type d -print 2> /dev/null | sed 1d | cut -b3-"}"
    eval "$cmd" | $(__fzfcmd) -m | while read item; do
        printf '%q ' "$item"
    done
    echo
    }

    __fzfcmd() {
    [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
    }

    __fsel-last-cmd () {
    local cmd="$(fc -l -n -1)"
    eval "$cmd" | $(__fzfcmd) -m | while read item; do
        printf '%q ' "$item"
    done
    echo
    }

    fzf-last-cmd-widget() {
    LBUFFER="${LBUFFER}$(__fsel-last-cmd)"
    zle redisplay
    }
    zle     -N   fzf-last-cmd-widget
    # TODO find key binding
    # bindkey '^E' fzf-last-cmd-widget

    # CTRL-F - Paste the selected file path(s) into the command line
    fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    zle redisplay
    }
    zle     -N   fzf-file-widget
    bindkey '^F' fzf-file-widget

    fzf-dir-widget() {
    LBUFFER="${LBUFFER}$(__fsel-dir)"
    zle redisplay
    }
    zle     -N   fzf-dir-widget
    bindkey '^G' fzf-dir-widget

    # CTRL-G CTRL-G - cd into the selected directory
    fzf-cd-widget() {
    local cmd="${FZF_ALT_C_COMMAND:-"command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
        -o -type d -print 2> /dev/null | sed 1d | cut -b3-"}"
    cd "${$(eval "$cmd" | $(__fzfcmd) +m):-.}" && pwd
    zle reset-prompt
    }
    zle     -N    fzf-cd-widget
    # bindkey '\ec' fzf-cd-widget
    # bindkey 'ç' fzf-cd-widget
    bindkey '^G^G' fzf-cd-widget

    # CTRL-R - Paste the selected command from history into the command line
    fzf-history-widget() {
    local selected num
    selected=( $(fc -l 1 | $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r -q "${LBUFFER//$/\\$}") )
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
        zle vi-fetch-history -n $num
        fi
    fi
    zle redisplay
    }
    zle     -N   fzf-history-widget
    bindkey '^R' fzf-history-widget
fi

fpath=(/usr/local/share/zsh-completions $fpath)

source ~dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# source ~dotfiles/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh

source ~dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source ~dotfiles/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

export BAT_THEME="1337"

# source ~dotfiles/zsh/plugins/k/k.sh

## source completions and bindings
source ~dotfiles/zsh/plugins/fzf/fzf-completion.zsh
source ~dotfiles/zsh/plugins/fzf/fzf-git.zsh
# https://junegunn.kr/2016/07/fzf-git/
# source ~dotfiles/zsh/plugins/fzf/git-completion.zsh
# TODO steal, fullscreen
# source ~dotfiles/zsh/plugins/forgit/forgit.plugin.zsh

## default commands
export FZF_DEFAULT_COMMAND="
    (git ls-tree -r --name-only HEAD \$(git rev-parse --show-toplevel) ||
    rg --files --hidden --follow -g '!{.git,node_modules}/*') 2> /dev/null"

# {} single-quoted string of the current line.
# {+} space-separated list of the selected lines (or the current line if no selection was made) individually quoted.
# {q} current query string.
# TODO preview with someting fast, fallback to pygmentize
export FZF_DEFAULT_OPTS="--multi --cycle --select-1 --exit-0
    --border --margin 1% --prompt 'ϟ ' --no-height --no-reverse
    --reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
    --header='(^start) | (end\$) | (’exact) | (!not) | OR (^core go\$ | rb\$ | py\$)'
    --preview-window right:40%
    --preview '[[ -d {} ]] && tree -C {} | head -200 ||
               [[ \$(file --mime-type -b {}) =~ image ]] && ls -lah {} && imgcat --256 -w 80 {} 2> /dev/null ||
                 (ls -lah {} &&
                  pygmentize {} ||
                  cat {}) 2> /dev/null | head -500'
    --bind='?:toggle-preview'
    --bind 'ctrl-e:execute(\$EDITOR {})+accept'
    --bind 'ctrl-o:execute(open {})+accept'
    --bind 'ctrl-y:execute(echo {+}|pbcopy)'
    --bind 'ctrl-j:jump'"

# to apply the command to CTRL-T as well (CTRL-F in my case)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# TODO get cp working
# export FZF_CTRL_T_OPTS="--bind 'ctrl-x:execute(echo {}|awk '{print \$2}'|pbcopy)+accept'"

# export PROMPT='%F{green}%n%f@%F{blue}%m%f %F{red}%~ %f% %# '
# source /Users/markus.bayer/dev/impure/async.zsh && source /Users/markus.bayer/dev/impure/impure.zsh
source /Users/markus.bayer/dev/zsh-clean/clean.zsh
