#          ▄███████▄     ▄████████    ▄█    █▄       ▄████████  ▄████████
#          ▀█▀▄███▀▄▄   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄▄██▀ ███
#           ▄███▀   ▀ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀▀▀   ███
#         ▄███▀                ███   ███    ███   ▀███████████ ███    █▄
# ████    ███▄     ▄█    ▄█    ███   ███    ███     ███    ███ ███    ███
# ████     ▀████████▀  ▄████████▀    ███    █▀      ███    ███ ████████
#                                                   ███    ███

# ASCII-Art credits: http://patorjk.com/software/taag/#p=display&f=Delta%20Corps%20Priest%201&t=.zshrc

# TODO {{{
    # TODO: statusline, select jumpmarks, magic enter, cd ..,
    # color scheme env vars

    # iterm2 drag files to cmd
    # autocompletion
    # cd .. && ls; cd d && ls
    # globbing
    # global aliases
    # http://www.wunderline.rocks/
    # hashes
    # fzf bookmarks
    # sampson-chen/sack
    # aafire
    # fix paths with $HOME
    # link bin to scripts
    # zshmarks to hashes
    # o j
    # init script
    # prezto fzf_marks
# }}}

# zsh configs {{{
    # init completion
    autoload -U compinit && compinit
    # enable vcs_info used by the prompt
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn
    precmd() {
        vcs_info
    }

    # unset mailcheck, spellcheck
    unset MAILCHECK
    unsetopt correct_all
    setopt correct
    # <Space> before command prevent the command from being pushed to zsh_history
    setopt HIST_IGNORE_SPACE

    # dirstack {
        # usage:
        # $ dirs
        # $ 7
        DIRSTACKFILE="$HOME/.zsh/dirstack"
        DIRSTACKSIZE=20

        if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
          dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
          [[ -d $dirstack[1] ]] && cd $dirstack[1]
        fi

        chpwd() {
          print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
        }

        setopt autopushd pushdsilent pushdtohome
        # remove duplicate entries
        setopt pushdignoredups
        # this reverts the +/- operators.
        setopt pushdminus
    # }

    # environment {
        export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$PATH"

        export TERM=xterm-256color

        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR='vim'
        else
          export EDITOR='/usr/local/Cellar/macvim/7.4-99/bin/mvim'
          export EDITOR_TAB=${EDITOR}' --remote-tab-silent'
        fi

        export HOME=/Users/mbayer
        export LANG=de_DE.UTF-8
        export LC_ALL=de_DE.UTF-8
    # }

    # colored dirs
    alias dircolors='gdircolors'
    eval `dircolors /Users/mbayer/Settings/dotfiles/monobay.256dark`

# }}}

# antigen {{{
    source $HOME/.oh-my-zsh/custom/plugins/antigen/antigen.zsh

    # load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle osx
    antigen bundle brew
    antigen bundle git
    antigen bundle python
    antigen bundle pip
    antigen bundle docker
    antigen bundle jsontools
    antigen bundle urltools
    antigen bundle web-search

    # additional bundles
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-history-substring-search

    antigen bundle jocelynmallon/zshmarks

    # Tell antigen that you're done.
    antigen apply
# }}}

# oh-my-zsh configs {{{

    ZSH=$HOME/.oh-my-zsh

    ZSH_THEME="impure"
    # ZSH_THEME="bay"
    # ZSH_THEME="random"
    CASE_SENSITIVE="false"
    COMPLETION_WAITING_DOTS="false"

    plugins=(impure)

    source $ZSH/oh-my-zsh.sh
# }}}


# python {{{
    path=(
        $path
        /usr/bin/python
        /usr/local/bin/python3
    )

    # virtualenv {
        export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
        export PROJECT_HOME=$HOME/Workspace
        export WORKON_HOME=$HOME/Workspace/Envs
        export VIRTUALENV_ROOT=$WORKON_HOME
        source /usr/local/bin/virtualenvwrapper.sh

        # fix the new tab = virtual_env dir bug
        if [[ "$PWD" == "$HOME/Workspace/Envs" ]]; then
            cd - > /dev/null
        fi
        # set default virtual_env
        if [[ $(basename "$VIRTUAL_ENV") == "" ]]
        then
            local virtualenv_default_path="$HOME/Workspace/Envs/python2.7.5/bin/activate"
            if [[ -f "$virtualenv_default_path" ]]; then
                source "$virtualenv_default_path"
            fi
        fi
    # }
# }}}

# docker {{{
    $(boot2docker shellinit 2> /dev/null)
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
# }}}

# hashes / named directories {{{
    hash -d dev=~/Workspace
    hash -d bay=~/Workspace/bay
    hash -d fzf_marks=~/Workspace/fzf_marks
    hash -d gists=~/Workspace/gists
    hash -d hackedHN=~/Workspace/hackedHN
    hash -d moment=~/Workspace/moment
    hash -d jason=~/Workspace/moment/jason
    hash -d impure=~/Workspace/impure
    hash -d regiobot=~/Workspace/regiobot
    hash -d rg=~/Workspace/regiobot/regiobot
    hash -d intersport=~/Workspace/regiobot/regiobot/intersport
    hash -d scripts=~/Workspace/scripts
    hash -d termxplorer=~/Workspace/termxplorer
    hash -d tx=~/Workspace/termxplorer/docker
    hash -d til=~/Workspace/til
    hash -d dotfiles=~/Settings/dotfiles
    hash -d colors=~/Settings/colors
    hash -d oh-my-zsh=~/.oh-my-zsh
    hash -d custom=~/.oh-my-zsh/custom
    hash -d bin=~/bin
    hash -d desktop=~/Desktop
    hash -d documents=~/Documents
    hash -d firma=~/Documents/firma
    hash -d plan=~/Documents/plan
    hash -d downloads=~/Downloads
    hash -d dropbox=~/Dropbox
    hash -d pictures=~/Pictures
    hash -d library=~/Library
    hash -d settings=~/Settings
    hash -d trash=~/.Trash
    hash -d intenso32=/Volumes/INGOT32/

    # files
    hash -d rg_ctrl=~/Workspace/regiobot/regiobot/web/regiobot/static/regiobot/js/regiobot_ctrl.js
    hash -d zshrc=~/.zshrc
    hash -d vimrc=~/.vimrc
    hash -d zsh_cheatsheet=~/Workspace/gists/zsh_cheatsheet/zsh.md
    hash -d vim_cheatsheet=~/Workspace/gists/vim_cheatsheet/vim.md
# }}}

# keybindings / keymappings {{{
    # vi mode
    # bindkey -v

    # TODO: remove
    # bind UP and DOWN arrow keys to history-substring-search
    # zmodload zsh/terminfo
    # bindkey "$terminfo[kcuu1]" history-substring-search-up
    # bindkey "$terminfo[kcud1]" history-substring-search-down

    bindkey -e
    export WORDCHARS=''                                 # do not jump over whole POSIX path
    bindkey 'å' accept-and-hold                         # alt a
    bindkey '^[^[[D' backward-word                      # alt <arrow-left>
    bindkey '^[^[[C' forward-word                       # alt <arrow-right>
    bindkey '^[^H' backward-kill-word                   # cmd <del>
    bindkey '^A' beginning-of-line                      # cmd <arrow-left>
    bindkey '^E' end-of-line                            # cmd <arrow-right>
    bindkey '^[^[[B' kill-whole-line                    # cmd <down-arrow>
    bindkey '^X' delete-char                            # ctrl x
    bindkey '^W' delete-word                            # ctrl w
    bindkey -s '^[^[[A' 'cd ..\n'                       # alt <arrow-up>
    bindkey -s '^L' 'ls -laH\n'                         # ctr l
    bindkey '^[[A' history-beginning-search-backward    # <arrow-up>
    bindkey '^[[B' history-beginning-search-forward     # <arrow-down>
# }}}

# aliases {{{
    # list {
        alias j='jump'
        alias ls='gls --color=auto'
        alias ll="ls -lah"
        alias lss='ls -lahS'                # sort by size
        alias lt='ls -latr'                 # sort by date
        # numFiles: number of (non-hidden) files in current directory
        alias num_files='echo $(ls -1 | wc -l)'
    # }

    # tools {
    alias ag='ag --path-to-agignore ~/.agignore'
    alias grep='grep --color'
    alias df='df -h'
    alias pony='fortune | ponysay'
    alias wttr='curl http://wttr.in'
    alias moon='curl http://wttr.in/Moon'
    alias yt3='cd $HOME/Downloads; youtube-dl --verbose --extract-audio --audio-format mp3 '

        # vim {
        alias mvim='/usr/local/Cellar/macvim/7.4-99/bin/mvim'
        alias vim='/usr/local/bin/vim'
        alias tvim="mvim --remote-tab-silent"
        # }

        # git {
            # find all .git directories and exec "git pull" on the parent.
            alias gprec='find . -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'
            alias git_ignore_del='git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin'
            alias gh='git config --get remote.origin.url'
        # }
    # }

    # actions {
        alias s='source ~/.zshrc'
        alias doch='su -c "$(history -p !-1)"'
        alias printip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
        alias dirs='dirs -vp'
        # substitute windows linebreak with unix linebreak
        alias fix_win="/usr/bin/perl -i -pe's/\r$//'"

        # osx {
            alias show_hidden='defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder'
            alias hide_hidden='defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder'
            alias empty_trash="rm -rf ~/.Trash/."
        # }

        # cleanup {
            # rm_DS_Store_files: removes all .DS_Store file from the current dir and below
            alias rm_ds_store='find . -name .DS_Store -exec rm {} \;'
            alias rm_pyc_files='find . -name "*.pyc" -exec rm {} \;'
            alias rm_svn_files='find . -type d -name .svn -exec rm -rf {} \;'
        # }

        # directory navigation {
            alias ..='cd ..'
            alias ...='cd ../..'
            alias ....='cd ../../..'
            alias .....='cd ../../../..'
            alias ......='cd ../../../../..'
            alias .......='cd ../../../../../..'
            alias ........='cd ../../../../../../..'
            alias .........='cd ../../../../../../../..'
        # }

        # file-shortcuts {
            alias zshrc='mvim --remote-tab-silent $HOME/Settings/dotfiles/zshrc.zsh'
            alias vimrc='mvim --remote-tab-silent $HOME/Settings/dotfiles/vimrc.vim'
        # }
    # }
# }}}

# functions {{{
    bookmarks_to_hashes () {
        cat zshmarks | awk '(FS = "|") && (NF) { gsub(/\$HOME/, "~", $1); print "hash -d " $2 "=" $1 }'
    }
    # regiobot {
        # init regiobot docker
        rg_init () {
            cd ~/Workspace/regiobot/regiobot/
            docker-machine stop regiobot
            docker-machine start regiobot
            eval "$(docker-machine env regiobot)"
            make up
        }

        # open a bash session in the regiobot docker
        rg_shell () {
            eval "$(docker-machine env regiobot)"
            docker exec -it $(docker ps | awk '{ if ($2 == "regiobot_django") print $1 }') /bin/bash
        }
    # }

    # move to trash
        trash () {
            mv "$@" $HOME/.Trash/.
        }
    # }

    # backup the current directory
    # {
        bu () {
            alias bu='tar -czf "../$(basename $(pwd))_$(date +%d%m%y-%H-%M-%S).tar.gz" .'
            dname=$(basename $(pwd))
            buname=$dname""_$(date +%d%m%y-%H-%M-%S).tar.gz
            cd ..
            tar -czf "$buname" "$dname/"
            echo "-> ../$buname"
            cd -  >/dev/null 2>&1
        }
    # }

    # show the git log as json
    git_log_json () {
        git log --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},'
    }
    # open files from asgard
    asgard_open () {
        mvim -c "echo :set buftype: \" \"" --remote-tab-silent scp://asgard//"$@"
    }

    # start vim with python 2 venv then switch back
    pvim () {
        venv="${VIRTUAL_ENV##*/}"
        if [[ $venv != "" ]]
        then
            workon python2.7.5
            mvim
            workon $venv
        else
            mvim
        fi
    }

    # open a url
    function op () {
        typeset -A mapping
        mapping=(
            google https://www.google.de/
            spotify https://play.spotify.com/collection/songs
        )
        open $mapping[$@]
    }

    # showTimes: show the modification, metadata-change, and access times of a file
    showtimes () { stat -f "%N:   %m %c %a" "$@" ; }
    # searching
    # ff:  to find a file under the current directory
    ff () { /usr/bin/find . -name "$@" ; }

    # ffs: to find a file whose name starts with a given string
    ffs () { /usr/bin/find . -name "$@"'*' ; }

    # ffe: to find a file whose name ends with a given string
    ffe () { /usr/bin/find . -name '*'"$@" ; }

    # fd: find a directory
    fd () { /usr/bin/find . -type d -name '*'"$@" ; }

    # ffg:  to find a file under the current git directory
    ffg () { /usr/bin/find `git rev-parse --show-toplevel` -name "$@" ; }

    # ffsg: to find a file whose name starts with a given string within the current git dir
    ffsg () { /usr/bin/find `git rev-parse --show-toplevel` -name "$@"'*' ; }

    # ffeg: to find a file whose name ends with a given string within the current git dir
    ffeg () { /usr/bin/find `git rev-parse --show-toplevel` -name '*'"$@" ; }

    # fdg: find a directory within the current git dir
    fdg () { /usr/bin/find `git rev-parse --show-toplevel` -type d -name '*'"$@" ; }

    # ack within the git dir
    ackg () { /usr/local/bin/ack "$@" `git rev-parse --show-toplevel` ; }
    gack () { ackg "$@" ; }

    # grepfind: to grep through files found by find, e.g. grepf pattern '*.c'
    # note that 'grep -r pattern dir_name' is an alternative if want all files
    grepfind () { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }

    # locatemd: to search for a file using Spotlight's metadata
    finder () { mdfind "kMDItemDisplayName == '$@'wc"; }

    # finderComment: show the SpotLight comment for a file
    findercomment () { mdls "$1" | grep kMDItemFinderComment ; }

    # locaterecent: to search for files created since yesterday using Spotlight
    # This is an illustration of using $time in a query
    # See: http://developer.apple.com/documentation/Carbon/Conceptual/SpotlightQuery/index.html
    findrecent () { mdfind 'kMDItemFSCreationDate >= $time.yesterday'; }

    # list_all_apps: list all applications on the system
    list_all_apps () { mdfind 'kMDItemContentTypeTree == "com.apple.application"c' ; }

    # find_larger: find files larger than a certain size (in bytes)
    find_larger () { find . -type f -size +${1}c ; }

    # findword: search for a word in the Unix word list
    findword () { /usr/bin/grep ^"$@"$ /usr/share/dict/words ; }

    # requires: pip install dict.cc.py
    # lookup dict.cc for german words
    # TODO use pip
    de () { $HOME/Utils/dict.cc.py/dict.cc.py de en "$1"; }
    # lookup dict.cc for english words
    en () { $HOME/Utils/dict.cc.py/dict.cc.py en de "$1"; }

    # copy the current working dir to clipboard
    cwd () { pwd | pbcopy }

    # serve wd
    serve () {
        printip
        python -m SimpleHTTPServer
    }

    # eject All Mountable Volumes
    eject () {
        osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
    }

    # Change Working Directory to Finder Path
    cdf () {
        cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
    }

    # count files
    count () {
        for dir in $( find . -type d -print ); do files=$( find $dir -maxdepth 1 -type f | wc -l ); echo "$dir : $files"; done
    }

    # calculator
    = () {
        calc="${@//p/+}"
        calc="${calc//x/*}"
        echo "$(($calc))"
    }

    # zipf: to create a ZIP archive of a file or folder
    zipf () { zip -r "$1".zip "$1" ; }

    # extract an archive
    # {
        extract () {
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
    # }

    # show available color codes
    # {
        typeset -Ag FX FG BG

        FX=(
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

        ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

        # Show all 256 colors with color number
        # TODO bold
        spectrum_ls () {
          for code in {000..255}; do
            print -P -- "$code: %F{$code}$ZSH_SPECTRUM_TEXT%f"
          done
        }

        # Show all 256 colors where the background is set to specific color
        spectrum_bls () {
          for code in {000..255}; do
            print -P -- "$BG[$code]$code: $ZSH_SPECTRUM_TEXT %{$reset_color%}"
          done
        }
    # }

    # tab completion for commands (input from last command)
    # {
        _prev-result () {
            hstring=$(eval `fc -l -n -1`)
            set -A hlist ${(@s/
/)hstring}
            compadd - ${hlist}
        }

        zle -C prev-comp menu-complete _prev-result
        # use with <esc>e:
        # find . -name "settings.py.*"
        # vim <Esc>e<Tab>
        bindkey '\ee' prev-comp
    # }

    # cd to git root
    # {
        cdg () {
            cd `git rev-parse --show-toplevel`
        }
    # }

    # list git tree
    # {
        git_tree () {
            (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null
        }
    # }

    # git push -u origin {BRANCH_NAME}
    # {
        git_push_branch () {
            git push -u origin "$(git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
        }
    # }

    # toggle show/hide hidden files in finder
    # {
        toggle_hidden () {
            isVisible=$(defaults read com.apple.finder AppleShowAllFiles)

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
    # }

    # show clock
    # {
        clock () {
            while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &
        }
    # }

    # nyan cat
    function nyan () { telnet nyancat.dakko.us }

    # starwars
    function starwars () { telnet towel.blinkenlights.nl }

    # mandelbrot
    # {
        function mandelbrot () {
           local lines columns colour a b p q i pnew
           ((columns=COLUMNS-1, lines=LINES-1, colour=0))
           for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
               for ((a=-2.0; a<=1; a+=3.0/columns)) do
                   for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
                       ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
                   done
                   ((colour=(i/4)%8))
                    echo -n "\\e[4${colour}m "
                done
                echo
            done
        }
    # }

    # say
    # {
        function lol() { say -v Hysterical 'hahahahahahaha oh really?' }

        function sing_song() {
            songs=(
                "say -v Pipe Organ Dum dum dee dum dum dum dum dee Dum dum dee dum dum dum dum dee dum dee dum dum dum de dum dum dum dee dum dee dum dum dee dummmmmmmmmmmmmmmmm" \
                "say -v Cellos di di di di di di di di di di di di di di di di di di di di di di di di di di" \
                "say -v Cellos oh This is a ponci song ponci song ponci song this is the ponsiano song ive ever ever heard So why keep you listening listening listening while you are supposed to hack to hack to hack to hack its because i hate bill gates hate bill gates hate bill gates its because i hate bill gates more than anything else No its because windows life windows life windows life and you better get a macintosh and iPod now" \
                "say -v Good oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooo" \
                "say -v Bad oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooo")
            ponysay $songs[$1]
            eval ${songs[$1]}
        }
    # }

    # set alarm clock
    alarm () {
        echo "alarm in ""$1""m"
        sleep "$(($1 * 60))" && sing_song 2
        # sleep "$(($1 * 60))" && mp3blaster ~/Music/gong.mp3
    }

    # enter = ls && git status
    # {
        function do_enter() {
            if [ -n "$BUFFER" ]; then
                zle accept-line
                return 0
            fi
            echo
            ls
            if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
                echo
                echo -e "\e[0;33m--- git status ---\e[0m"
                git status -sb
            fi
            zle reset-prompt
            return 0
        }
        zle -N do_enter
        bindkey '^m' do_enter
    # }

    # explain tools
    # {
    explain () {
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
    # }
# }}}

# plugins {{{
    # fortune ponies {
        fortune | ponysay
    # }

    # zshmarks {
        # zshmarks bookmarks folder
        export BOOKMARKS_FILE=~/.zsh/zshmarks
    # }

    # fzf {
        source ~/.oh-my-zsh/custom/plugins/fzf/completion.zsh
        source ~/.oh-my-zsh/custom/plugins/fzf/key-bindings.zsh

        fzf_filter() {
            vim $(fc -e -|fzf)
        }

        # fzf bms {
            alias fm='. fm'
            FZF_MARKS_DIRMARKS=~/.fzf_dirmarks
            FZF_MARKS_FILEMARKS=~/.fzf_filemarks
            FZF_MARKS_TEXT_ACTION=${EDITOR_TAB}
            FZF_MARKS_FILE_ACTION='open'
            FZF_MARKS_DIR_ACTION='cd'
            # alias do_cd='cd $1'
            # do_cd() {
            #     cd "$1"
            # }
        # }


                # ag -g "" --path-to-agignore ~/.agignore'
        export FZF_DEFAULT_COMMAND='
            (git ls-files $(git rev-parse --show-toplevel) ||
                find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
                sed s/^..//) 2> /dev/null'

        # Feed the output of ag into fzf
        alias fzf_ag='ag -g "" | fzf'

        # To apply the command to CTRL-T as well
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

        # fzf open
        # fe [FUZZY PATTERN] - Open the selected file with the default editor
        #   - Bypass fuzzy finder if there's only one match (--select-1)
        #   - Exit if there's no match (--exit-0)
        # you can press
        #   - CTRL-O to open with `open` command,
        #   - CTRL-E or Enter key to open with the $EDITOR
        fo () {
          local out file key
          out=$(fzf --query="$1" --exit-0 --select-1 --exit-0 --cycle --expect=ctrl-o,ctrl-e)
          key=$(head -1 <<< "$out")
          file=$(head -2 <<< "$out" | tail -1)
          if [ -n "$file" ]; then
            [ "$key" = ctrl-o ] && open "$file" || eval ${EDITOR_TAB} "$file"
          fi
        }

        # fzf cd - cd to selected directory
        fcd () {
          local dir
          dir=$(find ${1:-*} -path '/*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf +m) &&
          cd "$dir"
        }

        fgcd () {
          local dir
          dir=$(find ${1:-*} -path $(echo $HOME)'/*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf +m) &&
          cd "$dir"
        }

    # }

# }}}

# vim: set ft=zsh ts=4 sw=4 expandtab :
