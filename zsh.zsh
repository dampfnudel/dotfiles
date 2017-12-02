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

# $PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$PATH"

# paths
# TODO hash?
export BIN=/usr/local/bin
export DOTFILES="$HOME/Settings/dotfiles"

# language
export LANG=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8

# history
# TODO rm 2
export HISTFILE="$HOME/.zsh_history2"
export HISTSIZE=1200000
export SAVEHIST=1000000

# $EDITOR
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="$BIN/vim"
else
    export EDITOR=~bin"/emacs"
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
eval $(gdircolors -b "$DOTFILES/monobay.256dark")

# project amber
export DJANGO_SETTINGS_MODULE=amber.settings



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
source "$BIN/virtualenvwrapper.sh"

# set default virtual_env
export VIRTUALENV_DEFAULT_PATH="$WORKON_HOME/python3.4.1/bin/activate"
# load it
if [[ $(basename "$VIRTUAL_ENV") == "" ]]
then
    if [[ -f "$VIRTUALENV_DEFAULT_PATH" ]]; then
        source "$VIRTUALENV_DEFAULT_PATH"
    fi
fi

# ripgrep as find
# TODO define in var
alias fd="rg --files --no-ignore --hidden --follow -g '!{.git,node_modules}/*'"
# create parent directories on demand
alias mkdir="mkdir -pv"
# disk usage statistics default
alias du="du -ach | sort"
# continue the download in case of problems
alias wget="wget -c"

# filter columns
alias -g _awk1="|awk '{print \$1}'"
alias -g _awk2="|awk '{print \$2}'"
alias -g _awk3="|awk '{print \$3}'"
alias -g _awk4="|awk '{print \$4}'"
alias -g _awk5="|awk '{print \$5}'"
alias -g _awk6="|awk '{print \$6}'"
# filter with fzf
alias -g _f="|fzf"
# count lines
alias -g _cl='|wc -l'
# archives in pwd
alias -g _acd='./(*.bz2|*.gz|*.tgz|*.zip|*.z)'

# TODO
# open org-mode files in emacs
alias -s org=emacs

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

function fdr() {
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

function human_time_cat () {
    # print unix timestamps in human readable form
    if [ $# -eq 0 ]; then echo "Argument required"; return 1; fi
    perl -lne 'm#: (\d+):\d+;(.+)# && printf "%s :: %s\n",scalar localtime $1,$2' $1
}

function latest_in () {
    # select file in a given directory (sorted by dates)
    if [ $# -eq 0 ]; then echo "Argument required"; return 1; fi
    ls -1t "$1" | fzf
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

## movement http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Movement
bindkey '^[^[[D' backward-word                      # alt <arrow-left>............move a word backward
bindkey '^[^[[C' forward-word                       # alt <arrow-right>...........move a word forward
bindkey '^A' beginning-of-line                      # cmd <arrow-left>............move to the beginning of the line
bindkey '^E' end-of-line                            # cmd <arrow-right>...........move to the end of the line
bindkey '^[[1;2B' down-line
bindkey '^[[1;2A' up-line
bindkey '^N' vi-find-next-char

## Modifying-Text http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Modifying-Text
bindkey ';6D' copy-prev-word # ctr shift <-

## kill
bindkey '^[^H' backward-kill-word                   # cmd <del>...................delete the word left of the cursor
bindkey '^[csd' backward-kill-word
bindkey '^X' delete-char                            # ctrl x......................delete the char under the cursor
bindkey '^[csku' kill-line
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
#bindkey '^[^[[B' kill-whole-line                    # cmd <arrow-down>............delete the whole line

## other
bindkey '^[[5~' up-history
# ctrl s
bindkey '^[cks' accept-and-hold                        # ctrl n .................... multiselect in menu complete
bindkey -s '^[^[[A' 'cd ..\n'                       # alt <arrow-up>..............cd ..
bindkey -s '^L' 'ls -laH\n'                         # ctr l.......................ls -laH
if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

## history
# bindkey '^[u' history-substring-search-up
# bindkey '^[d' history-substring-search-down

bindkey '^[u' history-search-multi-word
bindkey '^[d' history-search-multi-word-backwards


## mark
# alt down
bindkey '^[^[[B' set-mark-command
# alt up
bindkey '^[^[[A' deactivate-region

function repeat-cmd () {
    # repeat the last command
    zle up-history
    zle accept-line
}

zle -N repeat-cmd
# ctrl l
bindkey '^H' repeat-cmd

function kill-first-word () {
    # kill the first word on the cmdline and move cursor to beginning of line
    zle beginning-of-line
    zle forward-word
    zle backward-kill-word
    zle magic-space
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

source ~dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~dotfiles/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh

#source ~dotfiles/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source ~dotfiles/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

## source completions and bindings
source ~dotfiles/zsh/plugins/fzf/completion.zsh
# https://junegunn.kr/2016/07/fzf-git/
source ~dotfiles/zsh/plugins/fzf/git-completion.zsh
source ~dotfiles/zsh/plugins/fzf/key-bindings.zsh
# TODO steal, fullscreen
source ~dotfiles/zsh/plugins/forgit/forgit.plugin.zsh

## default commands
export FZF_DEFAULT_COMMAND="
    (git ls-tree -r --name-only HEAD \$(git rev-parse --show-toplevel) ||
    rg --files --no-ignore --hidden --follow -g '!{.git,node_modules}/*') 2> /dev/null"

# TODO preview with someting fast, fallback to pygmentize
export FZF_DEFAULT_OPTS="--multi --cycle --select-1 --exit-0
    --border --margin 1% --prompt 'ϟ ' --no-height --no-reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
    --header='Anchored-match (^music, .mp3\$) | Exact-Match (’quoted) | Negation (!fire) | OR operator (^core go\$ | rb\$ | py\$)'
    --preview '[[ -d {} ]] && tree -C {} | head -200 ||
                 (highlight -O ansi -l {} ||
                  ls -lah {} &&
                  pygmentize {} ||
                  cat {}) 2> /dev/null | head -500'
    --bind 'ctrl-e:execute(\$EDITOR {})+accept'
    --bind 'ctrl-o:execute(open {})+accept'
    --bind 'ctrl-y:execute(echo {}|pbcopy)+accept'
    --bind 'ctrl-j:jump'"

# to apply the command to CTRL-T as well (CTRL-F in my case)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# TODO get cp working
# export FZF_CTRL_T_OPTS="--bind 'ctrl-x:execute(echo {}|awk '{print \$2}'|pbcopy)+accept'"

export PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~% %# '
