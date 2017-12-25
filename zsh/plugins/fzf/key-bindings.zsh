# fzf keybindings
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

