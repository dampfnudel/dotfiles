#          ▄███████▄     ▄████████    ▄█    █▄       ▄████████  ▄████████
#          ▀█▀▄███▀▄▄   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄▄██▀ ███
#           ▄███▀   ▀ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀▀▀   ███
#         ▄███▀                ███   ███    ███   ▀███████████ ███    █▄
# ████    ███▄     ▄█    ▄█    ███   ███    ███     ███    ███ ███    ███
# ████     ▀████████▀  ▄████████▀    ███    █▀      ███    ███ ████████
#                                                   ███    ███

# ASCII-Art credits: http://patorjk.com/software/taag/#p=display&f=Delta%20Corps%20Priest%201&t=.zshrc

# TODO {{{
    # iterm2 drag files to cmd
    # global aliases
    # http://www.wunderline.rocks/
    # aafire
    # mdfind
    # structure!
    # fzf
        # BOOKMARKS!
        # -m
        # workon
        # context starting points
        # mru
    # REFACTOR
        # global vars
        # substitutions
            # home
            # projects
            # editor
            # oh-my-zsh
            # dotfiles
    # init script
# }}}

# zsh configs {{{
    # init completion
    autoload -U compinit && compinit
    # enable vcs_info used by the prompt
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn
    precmd() { vcs_info }

    # unset mailcheck, spellcheck
    unset MAILCHECK
    unsetopt correct_all
    setopt correct
    # <Space> before command prevent the command from being pushed to zsh_history
    setopt HIST_IGNORE_SPACE

    # # completion {
    #     # enable vcs_info used by the prompt
    #     autoload -U compinit && compinit
    #     autoload -Uz vcs_info
    #     zstyle ':vcs_info:*' enable git svn
    #     precmd () { vcs_info ; }
    #
    #     zstyle ':completion:*' completer _expand _complete
    #
    #     zstyle ':completion:*' use-cache on
    #     zstyle ':completion:*' users resolve
    #     # use dircolours in completion listings
    #     zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    #     # Enable menu completion
    #     zstyle ':completion*:default' menu 'select=1'
    #
    #     # allow approximate matching
    #     zstyle ':completion:*' completer _complete _match _approximate
    #     zstyle ':completion:*:match:*' original only
    #     zstyle ':completion:*:approximate:*' max-errors 1 numeric
    #     zstyle ':completion:*' auto-description 'Specify: %d'
    #     zstyle ':completion:*' format 'Completing %d'
    #     zstyle ':completion:*' verbose true
    #     zstyle ':completion:*:functions' ignored-patterns '_*'
    #     zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
    #     '*?.(o|c~|zwc)' '*?~'
    #
    #     zstyle ':completion:*:vim:*' ignored-patterns '*.(o|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
    #
    #     # init completion
    #     autoload -U compinit && compinit
    # #}

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
          export EDITOR='/usr/local/bin/vim'
        else
          export EDITOR='/usr/local/Cellar/macvim/7.4-99/bin/mvim'
          export EDITOR_TAB=${EDITOR}' --remote-tab-silent'
        fi

        export HOME=/Users/mbayer
        export LANG=de_DE.UTF-8
        export LC_ALL=de_DE.UTF-8
    # }

    # gnu dircolors
    alias dircolors='gdircolors'
    eval `dircolors /Users/mbayer/Settings/dotfiles/monobay.256dark`
# }}}

# antigen {{{
    # source $HOME/.oh-my-zsh/custom/plugins/antigen/antigen.zsh
    #
    # # load the oh-my-zsh's library.
    # antigen use oh-my-zsh
    #
    # # bundles from the default repo (robbyrussell's oh-my-zsh).
    # antigen bundle osx
    # antigen bundle brew
    # antigen bundle git
    # antigen bundle python
    # antigen bundle pip
    # antigen bundle docker
    # antigen bundle jsontools
    # antigen bundle urltools
    # antigen bundle web-search
    #
    # # additional bundles
    # antigen bundle zsh-users/zsh-syntax-highlighting
    # antigen bundle zsh-users/zsh-autosuggestions
    # antigen bundle zsh-users/zsh-completions
    # antigen bundle zsh-users/zsh-history-substring-search
    #
    # antigen bundle jocelynmallon/zshmarks
    #
    # # Tell antigen that you're done.
    # antigen apply
# }}}

# oh-my-zsh configs {{{

    ZSH=$HOME/.oh-my-zsh

    ZSH_THEME="impure"
    # ZSH_THEME="bay"
    # ZSH_THEME="random"
    CASE_SENSITIVE="false"
    COMPLETION_WAITING_DOTS="false"

    plugins=(
        osx
        brew
        git
        python
        pip
        zshmarks
        pure
        docker
        jsontools
        urltools
        web-search
        zsh-completions
        zsh-syntax-highlighting
        zsh-history-substring-search
        impure)

    source $ZSH/oh-my-zsh.sh
# }}}

# plugins-settings {{{
    # fortune ponies {
        fortune | ponysay
    # }

    # fzf {
        source ~/.oh-my-zsh/custom/plugins/fzf/completion.zsh
        source ~/.oh-my-zsh/custom/plugins/fzf/key-bindings.zsh

                # ag -g "" --path-to-agignore ~/.agignore'
        export FZF_DEFAULT_COMMAND='
            (git ls-files $(git rev-parse --show-toplevel) ||
                /user/bin/find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
                sed s/^..//) 2> /dev/null'

        # Feed the output of ag into fzf
        alias fzf_ag='ag -g "" | fzf'

        # To apply the command to CTRL-T as well
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

        # fzf bms {
            alias fm='. fm'
            FZF_MARKS_DIRMARKS=~/.fzf_dirmarks
            FZF_MARKS_FILEMARKS=~/.fzf_filemarks
            FZF_MARKS_TEXT_ACTION=${EDITOR_TAB}
            FZF_MARKS_FILE_ACTION='open'
            FZF_MARKS_DIR_ACTION='cd'
        # }
    # }
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
    hash -d dev=$HOME/Workspace
    hash -d bay=$HOME/Workspace/bay
    hash -d fzf_marks=$HOME/Workspace/fzf_marks
    hash -d gists=$HOME/Workspace/gists
    hash -d hackedHN=$HOME/Workspace/hackedHN
    hash -d moment=$HOME/Workspace/moment
    hash -d jason=$HOME/Workspace/moment/jason
    hash -d impure=$HOME/Workspace/impure
    hash -d regiobot=$HOME/Workspace/regiobot
    hash -d rg=$HOME/Workspace/regiobot/regiobot
    hash -d intersport=$HOME/Workspace/regiobot/regiobot/intersport
    hash -d scripts=$HOME/Workspace/scripts
    hash -d termxplorer=$HOME/Workspace/termxplorer
    hash -d test=$HOME/Workspace/test_repo
    hash -d tx=$HOME/Workspace/termxplorer/docker
    hash -d til=$HOME/Workspace/til
    hash -d dotfiles=$HOME/Settings/dotfiles
    hash -d colors=$HOME/Settings/colors
    hash -d oh-my-zsh=$HOME/.oh-my-zsh
    hash -d custom=$HOME/.oh-my-zsh/custom
    hash -d bin=$HOME/bin
    hash -d desktop=$HOME/Desktop
    hash -d documents=$HOME/Documents
    hash -d firma=$HOME/Documents/firma
    hash -d plan=$HOME/Documents/plan
    hash -d downloads=$HOME/Downloads
    hash -d dropbox=$HOME/Dropbox
    hash -d pictures=$HOME/Pictures
    hash -d library=$HOME/Library
    hash -d settings=$HOME/Settings
    hash -d trash=$HOME/.Trash
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

    # widgets
    # _last_command_args() {
    #     last_command=$history[$[HISTCMD-1]]
    #     last_command_array=("${(s/ /)last_command}") 
    #     _sep_parts last_command_array
    # }
    # zstyle ':completion:*' completer _last_command_args _complete

        # tab completion for the output of the previous command {
            _prev_result () {
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

        # tab completion for git status files {
            _git_status_files () {
                files=$(git status --porcelain | awk '{print $2 }')
                set -A flist ${(@s/
/)files}
                compadd - ${flist}
            }

            zle -C git-files menu-complete _git_status_files
            # usage
            # $ git add <Escape>g<Tab>
            bindkey '\eg' git-files
        # }

        # fzf filter for the output of the previous command {
            fzf_filter_prev () {
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

        # magic enter = ls && git status {
            do_enter () {
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

        # rational dots {
            # type '...' to get '../..' with successive .'s adding /..
            function rationalise-dot {
                local MATCH # keep the regex match from leaking to the environment
                if [[ $LBUFFER =~ '(^|/| |      |'$'\n''|\||;|&)\.\.$' ]]; then
                  LBUFFER+=/
                  zle self-insert
                  zle self-insert
                else
                  zle self-insert
                fi
            }
            zle -N rationalise-dot
            bindkey . rationalise-dot
            # without this, typing a . aborts incremental history search
            bindkey -M isearch . self-insert
        # }
    # }

    bindkey -e
    export WORDCHARS=''                                 # do not jump over whole POSIX path
    bindkey 'å' accept-and-hold                         # alt a.......................multiselect in menu complete
    bindkey '^[^[[D' backward-word                      # alt <arrow-left>............move a word backward
    bindkey '^[^[[C' forward-word                       # alt <arrow-right>...........move a word forward
    bindkey '^[^H' backward-kill-word                   # cmd <del>...................delete the word left of the cursor
    bindkey '^A' beginning-of-line                      # cmd <arrow-left>............move to the beginning of the line
    bindkey '^E' end-of-line                            # cmd <arrow-right>...........move to the end of the line
    bindkey '^[^[[B' kill-whole-line                    # cmd <arrow-down>............delete the whole line
    bindkey '^X' delete-char                            # ctrl x......................delete the char under the cursor
    bindkey '^W' delete-word                            # ctrl w......................delete the word under the cursor
    bindkey -s '^[^[[A' 'cd ..\n'                       # alt <arrow-up>..............cd ..
    bindkey -s '^L' 'ls -laH\n'                         # ctr l.......................ls -laH
    bindkey '^[[A' history-beginning-search-backward    # <arrow-up>..................history substring search backward
    bindkey '^[[B' history-beginning-search-forward     # <arrow-down>................history substring search forward
# }}}

# aliases {{{
    # filters / global aliases {
        alias -g _null="> /dev/null 2>&1"
        alias -g _vim="| eval ${EDITOR_TAB}"
        alias -g _cc='| pbcopy'
    # }

    # list {
        alias ls='gls --color=auto'
        alias ll='ls -lah'
        alias ls_size='ls -lahS'                # sort by size
        alias ls_date='ls -latr'                 # sort by date
        # numFiles: number of (non-hidden) files in current directory
        alias ls_count='echo $(ls -1 | wc -l)'
    # }

    # tools {
    alias ag='ag --path-to-agignore ~/.agignore'
    alias grep='grep --color'
    alias df='df -h'
    alias pony='fortune | ponysay'
    alias wttr='curl http://wttr.in'
    alias moon='curl http://wttr.in/Moon'
    alias yt3='cd $HOME/Downloads; youtube-dl --verbose --extract-audio --audio-format mp3 '
    # alias emacs='/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs'
    alias emacs='open -a Emacs.app'
    alias cemacs='/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw'

        # vim {
            alias mvim=${EDITOR}
            alias cvim='/usr/local/bin/vim'
            alias tvim=${EDITOR_TAB}
            alias vim=${EDITOR_TAB}
        # }

        # git {
            # find all .git directories and exec "git pull" on the parent.
            alias git_pull_rec='find . -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'
            alias git_ignore_del='git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin'
            alias git_remote_url='open `git config --get remote.origin.url`'
            alias git_gitst_remote_url='open `git config --get remote.origin.url` | cut -c5-'
            alias git_commit_fire='git add -A && git commit -a --allow-empty-message -m "" && git push'
        # }
    # }

    # actions {
        alias s='source ~/.zshrc'
        alias i_am_root='su -c "$(history -p !-1)"'
        alias printip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
        alias dirs='dirs -vp'
        # substitute windows linebreak with unix linebreak
        alias fix_linebreaks="/usr/bin/perl -i -pe's/\r$//'"

        # osx {
            alias osx_show_hidden='defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder'
            alias osx_hide_hidden='defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder'
            alias osx_empty_trash="rm -rf ~/.Trash/."
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
    # list {{{
        escape_spaces () {
            echo "${(q)1}"
        }
        # print a directory tree
        dir_tree () {
            ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
        }
        # count files
        count () {
            for dir in $( /usr/bin/find . -type d -print );
            do
                files=$( /usr/bin/find $dir -maxdepth 1 -type f | wc -l )
                echo "$dir : $files"
            done
        }

        # showTimes: show the modification, metadata-change, and access times of a file
        showtimes () { stat -f "%N:   %m %c %a" "$@" ; }

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

        # ag within the git dir
        agg () { /usr/local/bin/ag "$@" `git rev-parse --show-toplevel` ; }
        gagg () { agg "$@" ; }

        # locatemd: to search for a file using Spotlight's metadata
        spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

        # finderComment: show the SpotLight comment for a file
        spotlight_comment () { mdls "$1" | grep kMDItemFinderComment ; }

        # locaterecent: to search for files created since yesterday using Spotlight
        # this is an illustration of using $time in a query
        # see: http://developer.apple.com/documentation/Carbon/Conceptual/SpotlightQuery/index.html
        # TODO: day param
        spotlight_recent_created () {
            mdfind 'kMDItemFSCreationDate >= $time.yesterday' | sed '/^\/Users\/mbayer\//!d' | sed '/^\/Users\/mbayer\/Library\//d' | sed '/pyc$/d'
        }

        mru () {
            find ~ \( -path '*/\.*' -o -path '/Users/mbayer/Library*' -o -path '/Users/mbayer/Pictures/Fotos-Mediathek.photoslibrary*' -o -path '/Users/mbayer/Workspace/Envs*' \) -prune -o \( -name '*\.pyc' \) -prune -o -type f -mtime -7 -perm -g+r,u+r,o+r -print | sed '/Dropbox.*Icon*/d'
        }

        # list_all_apps: list all applications on the system
        list_all_apps () { mdfind 'kMDItemContentTypeTree == "com.apple.application"c' ; }

        # find_larger: find files larger than a certain size (in bytes)
        find_larger () { /usr/bin/find . -type f -size +${1}c ; }

        # findword: search for a word in the Unix word list
        findword () { /usr/bin/grep ^"$@"$ /usr/share/dict/words ; }

        # dictionary lookup
        # dict_lookup is a python script which queries osx dict
        dict () {
            dict_lookup "$@"|tr '|' '\n'|sed 's/^ //g'
        }

        # fzf {
            # open screenshot
            fzf_open_screenshot () {
                local screenshot_path screenshot
                screenshot_path="$HOME/Pictures/Screenshots"
                screenshot=$(ls -r ${screenshot_path} | sed '/Bildschirmfoto/!d' | fzf)
                echo "$screenshot_path/${(q)screenshot}"
                open $screenshot
            }
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
              dir=$(/usr/bin/find ${1:-*} -path '/*/\.*' -prune \
                              -o -type d -print 2> /dev/null | fzf +m) &&
              cd "$dir"
            }

            # fcd starting from $HOME
            fgcd () {
              local dir
              dir=$(/usr/bin/find ${1:-*} -path $(echo $HOME)'/*/\.*' -prune \
                              -o -type d -print 2> /dev/null | fzf +m) &&
              cd "$dir"
            }

            # search for file contents
            fag () {
                ag --nobreak --nonumbers --noheading . | fzf
            }

            # fbr - checkout git branch (including remote branches)
            fzf_checkout () {
              local branches branch
              branches=$(git branch --all | grep -v HEAD) &&
              branch=$(echo "$branches" |
                       fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
              git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
            }
            # fco - checkout git branch/tag
            fzf_checkout_branch () {
              local tags branches target
              tags=$(
                git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
              branches=$(
                git branch --all | grep -v HEAD             |
                sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
                sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
              target=$(
                (echo "$tags"; echo "$branches") |
                fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
              git checkout $(echo "$target" | awk '{print $2}')
            }

            # fcoc - checkout git commit
            fzf_checkout_commit () {
              local commits commit
              commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
              commit=$(echo "$commits" | fzf --tac +s +m -e) &&
              git checkout $(echo "$commit" | sed "s/ .*//")
            }

            # fshow - git commit browser
            fzf_log () {
              git log --graph --color=always \
                  --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
              fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
                  --bind "ctrl-m:execute:
                            (grep -o '[a-f0-9]\{7\}' | head -1 |
                            xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                            {}
FZF-EOF"
            }

            # c - browse chrome history
            fzf_chrome_history () {
                  local cols sep
                  cols=$(( COLUMNS / 3 ))
                  sep='{{::}}'

                  # Copy History DB to circumvent the lock
                  # - See http://stackoverflow.com/questions/8936878 for the file path
                  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

                  sqlite3 -separator $sep /tmp/h \
                    "select substr(title, 1, $cols), url
                     from urls order by last_visit_time desc" |
                  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' |
                  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
            }
            # browse chrome bookmarks
            fzf_chrome_bookmarks () {
                $HOME/Workspace/scripts/fzf_chrome_bookmarks.rb
            }
        # }
    # }}}

    # vim {{{
        smart_open () {
            # escape spaces
            local filename cmd cmd_dir cmd_text cmd_arbitrary
            filename=${(q)1}

            cmd=""
            cmd_dir="cd $filename"
            cmd_text="${EDITOR_TAB} $filename"
            cmd_arbitrary="open $filename"

            # if directory
            if [[ -d "$filename" ]]; then
                cmd=$cmd_dir
            else
                # $1 == file

                # special case handling
                local file_extension file_exceptions
                file_extension="${filename##*.}"
                file_exceptions=(csv)
                for i in "${file_exceptions[@]}"
                do
                    if [[ "$i" == $file_extension ]]; then
                        cmd=$cmd_arbitrary
                    fi
                done

                # if meta information is text
                if [[ $(file "$filename" | awk '{print $NF}') == 'text' ]]; then
                    cmd=$cmd_text
                else
                    # fallback
                    cmd=$cmd_arbitrary
                fi
            fi

            if [[ $cmd != '' ]]; then
                echo ${cmd} && eval ${cmd}
            else
                echo "nothing to do here"
            fi
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
    # }}}

    # git {{{
        # cd to git root
        cdg () {
            cd `git rev-parse --show-toplevel`
        }

        # git status file list
        git_status_files () {
            git status --porcelain | awk '{print $2 }'
        }

        # list git tree
        git_tree () {
            (git ls-tree -r --name-only HEAD || /usr/bin/find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null
        }


        # pull all repositories under $pwd
        # git_pull_rec () {
        #     /usr/bin/find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
        # }

        # git push -u origin {BRANCH_NAME}
        git_push_branch () {
            git push -u origin "$(git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
        }

        # show the git log as json
        git_log_json () {
            git log --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},'
        }
    # }}}

    # docker {{{
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
    # }}}

    # track {{{
        # view a ticket by nr
        # -o -> open in browser
        trac_view () {
            local ticket_nr
            ticket_nr=$1
            if [[ ! $ticket_nr == '' ]]; then
                local ticket_url
                ticket_url=https://trac.inquant.de/regioyal/ticket/$ticket_nr

                if [[ "$2" == "-o" ]]; then
                    echo "🐾  $ticket"
                    echo "🔗  $ticket_url"
                    open https://trac.inquant.de/regioyal/ticket/$ticket_nr
                else
                    local ticket_description
                    ticket_description=`cm view $ticket_nr 2>/dev/null`
                    echo "🐾  $ticket_description"
                    echo ""
                    echo ""
                    echo "-----------------------------------"
                    echo "🔗  $ticket_url"
                fi
            fi
        }

        # search ticket titles via https://pypi.python.org/pypi/cartman/0.2.3
        trac_fzf_search () {
              local ticket ticket_nr
              ticket=$(cm report 3 2>/dev/null | fzf)
              ticket_nr=`echo $ticket | awk '{print $1}' | sed 's/[^0-9]*//g'`

                if [[ ! $ticket_nr == '' ]];then
                    trac_view $ticket_nr $1
                fi
        }

        # search tickets (trac_search "404 pages" -o)
        trac_search () {
              local ticket ticket_nr
              ticket=$(cm search "$1" 2>/dev/null | fzf)
              ticket_nr=`echo $ticket | awk '{print $1}' | sed 's/[^0-9]*//g'`

                if [[ ! $ticket_nr == '' ]];then
                    local last_param
                    eval last_param=\$$#
                    if [[ $last_param == '-o' ]];then
                        trac_view $ticket_nr $last_param
                    else
                        trac_view $ticket_nr
                    fi
                fi
        }
        # # $ cm comment 1 -m "you forgot to call twiddle()"
        # $ cm status 1
        # Set a ticket as accepted:
        # $ cm status 1 accept
    # }}}

    # actions {{{
        # create an executable script
        mk_script () {
            (($# > 0)) && {
                touch "$1"
                chmod +x "$1"
                eval ${EDITOR_TAB} "$1"
            }
        }

        # move file/dir to trash
        trash () { mv "$@" $HOME/.Trash/. ; }

        # backup the current directory under ../the-archive.tar.gz
        bu () {
            alias bu='tar -czf "../$(basename $(pwd))_$(date +%d%m%y-%H-%M-%S).tar.gz" .'
            dname=$(basename $(pwd))
            buname=$dname""_$(date +%d%m%y-%H-%M-%S).tar.gz
            cd ..
            tar -czf "$buname" "$dname/"
            echo "-> ../$buname"
            cd -  >/dev/null 2>&1
        }

        # convert a given zshmarks bookmarks file to zsh named directories
        bookmarks_to_hashes () {
            cat "$@" | awk '(FS = "|") && (NF) { gsub(/\$HOME/, "~", $1); print "hash -d " $2 "=" $1 }'
        }

        # lookup dict.cc
        de () { $HOME/Utils/dict.cc.py/dict.cc.py de en "$1"; }
        # lookup dict.cc for english words
        en () { $HOME/Utils/dict.cc.py/dict.cc.py en de "$1"; }

        # copy the current working dir to clipboard
        cwd () { pwd | pbcopy }

        # calculator
        = () {
            calc="${@//p/+}"
            calc="${calc//x/*}"
            echo "$(($calc))"
        }

        # show clock
        clock () {
            while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &
        }

        # explain tools
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

        # osx {
            # say
            lol () { say -v Hysterical 'hahahahahahaha oh really?' }

            sing_song () {
                songs=(
                    "say -v Pipe Organ Dum dum dee dum dum dum dum dee Dum dum dee dum dum dum dum dee dum dee dum dum dum de dum dum dum dee dum dee dum dum dee dummmmmmmmmmmmmmmmm" \
                    "say -v Cellos di di di di di di di di di di di di di di di di di di di di di di di di di di" \
                    "say -v Cellos oh This is a ponci song ponci song ponci song this is the ponsiano song ive ever ever heard So why keep you listening listening listening while you are supposed to hack to hack to hack to hack its because i hate bill gates hate bill gates hate bill gates its because i hate bill gates more than anything else No its because windows life windows life windows life and you better get a macintosh and iPod now" \
                    "say -v Good oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooo" \
                    "say -v Bad oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooo oooooooooooooooooooooooooooooooooooooooo­oooooooooooooooooooooooooooooooooooooooo­oooooooooo")
                ponysay $songs[$1]
                eval ${songs[$1]}
            }

            # set alarm clock with say
            alarm () {
                echo "alarm in ""$1""m"
                sleep "$(($1 * 60))" && sing_song 2
                # sleep "$(($1 * 60))" && mp3blaster ~/Music/gong.mp3
            }
            # eject all mountable volumes
            eject () {
                osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
            }

            # change working directory to Finder path
            cdf () {
                cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
            }

            # toggle show/hide hidden files in finder
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

        # archives {
            # zipf: to create a ZIP archive of a file or folder
            zipf () { zip -r "$1".zip "$1" ; }

            # extract an archive
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

        # network {
            # serve wd
            serve () {
                printip
                python -m SimpleHTTPServer
            }

            # open a url
            op () {
                typeset -A mapping
                mapping=(
                    google https://www.google.de/
                    spotify https://play.spotify.com/collection/songs
                )
                open $mapping[$@]
            }
        # }

        # color {
            # show available color codes
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

            # TODO bold
        # }

        # fun {
            # nyan cat
            nyan () { telnet nyancat.dakko.us }

            # starwars
            starwars () { telnet towel.blinkenlights.nl }

            # mandelbrot
            mandelbrot () {
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
    # }}}
# }}}
