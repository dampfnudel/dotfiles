#! /usr/bin/env zsh

# git functions utilizing fzf
#
# https://github.com/junegunn/fzf/wiki/Examples#git
# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# https://github.com/wfxr/forgit

# if available:
# diff with diff-so-fancy
# https://github.com/so-fancy/diff-so-fancy
# emojies with emojify
# https://github.com/mrowa44/emojify
(( $+commands[diff-so-fancy] )) && fancy='|diff-so-fancy'
(( $+commands[emojify] )) && emojify='|emojify'

function is_in_git_repo () {
    git rev-parse --is-inside-work-tree >/dev/null
}

function fzf_git () {
    HEADER="?:toggle-preview alt-v:page-up ctrl-v:page-down alt-k:preview-up alt-j:preview-down alt-a:select-all ctrl-r:toggle-all ctrl-s:toggle-sort alt-w:toggle-preview-wrap"
    fzf --border \
        --ansi \
        --cycle \
        --reverse \
        --bind='alt-v:page-up' \
        --bind='ctrl-v:page-down' \
        --bind='alt-k:preview-up,alt-p:preview-up' \
        --bind='alt-j:preview-down,alt-n:preview-down' \
        --bind='alt-a:select-all' \
        --bind='ctrl-r:toggle-all' \
        --bind='ctrl-s:toggle-sort' \
        --bind='?:toggle-preview' \
        --preview-window="right:60%" \
        --header="$HEADER" \
        --bind='alt-w:toggle-preview-wrap' "$@"
}

function git_file_fzf () {
    # print a selected index file
    is_in_git_repo || return
    git -c color.status=always status --short |
    fzf_git -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
    cut -c4- | sed 's/.* -> //'
}
alias gf='git_file_fzf'

function git_branch_fzf () {
    # print a selected branch name
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf_git --ansi --multi --tac --preview-window right:70% \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}
alias gb='git_branch_fzf'

function git_tag_fzf () {
    # print a selected tag name
    is_in_git_repo || return
    git tag --sort -version:refname |
    fzf_git --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$LINES
}

function git_hash_fzf () {
    # print the hash of a selected commit
    is_in_git_repo || return
    local cmd="echo {} |grep -o '[a-f0-9]\{7\}' |head -1 |xargs -I% git show --color=always % $emojify $fancy"
    git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr %C(blue) (%an)' $@ |
    fzf_git -e +s --tiebreak=index --preview="$cmd" |
    grep -o "[a-f0-9]\{7,\}"
}

function git_remote_fzf () {
    # print the selected remote
    is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf_git --tac \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
    cut -d$'\t' -f1
}

function join_lines () {
    local item
    while read item; do
        echo -n "${(q)item} "
    done
}

# keybindings
# insert the selection into the current commandline with a keybinding
function bind_git_helper () {
    local c="$1"
    local f="$2"
    eval "fzf-g$c-widget () { local result=\$($f | join_lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    # prefix Ctrl-G
    eval "bindkey '^g^$c' fzf-g$c-widget"
}
bind_git_helper f git_file_fzf
bind_git_helper b git_branch_fzf
bind_git_helper t git_tag_fzf
bind_git_helper h git_hash_fzf
bind_git_helper r git_remote_fzf
unset -f bind_git_helper

# functions with direct actions
function git_log_fzf () {
    # git commit browser
    is_in_git_repo || return 1
    local cmd="echo {} |grep -o '[a-f0-9]\{7\}' |head -1 |xargs -I% git show --color=always % $emojify $fancy"
    eval "git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr %C(blue) (%an)' $@ $emojify" |
        fzf_git -e +s --tiebreak=index \
            --bind="enter:execute($cmd |less -R)" \
            --preview="$cmd"
}

function git_diff_fzf () {
    # git diff brower
    is_in_git_repo || return
    local cmd="git diff --color=always -- {} $emojify $fancy"
    git ls-files --modified |
        fzf_git -e -0 \
            --bind="enter:execute($cmd |less -R)" \
            --preview="$cmd"
}

function git_add_fzf () {
    # git add selector
    is_in_git_repo || return 1
    # '31m' matches red color to filter out added files which is all green
    local files=$(git -c color.status=always status --short |
        grep 31m |
        awk '{printf "[%10s]  ", $1; $1=""; print $0}' |
        fzf_git -e -0 -m --nth 2..,.. \
            --preview="git diff --color=always -- {-1} $emojify $fancy" |
        cut -d] -f2 |
        sed 's/.* -> //') # for rename case
    [[ -n $files ]] && echo $files |xargs -I{} git add {} && git status
}

# git ignore generator
# https://www.gitignore.io/api/
export giCache=~/.giCache
export giIndex=$giCache/.list

function git_ignore_fzf () {
    [ -f $giIndex ] || gi_update_index
    local preview="echo {} |awk '{print \$2}' |xargs -I% bash -c 'cat $giCache/% 2>/dev/null || (curl -sL https://www.gitignore.io/api/% |tee $giCache/%)'"
    IFS=$'\n'
    [[ $# -gt 0 ]] && args=($@) || args=($(cat $giIndex |nl -nrn -w4 -s'  ' |fzf -m --preview="$preview" --preview-window="right:70%" |awk '{print $2}'))
    gi_get ${args[@]}
}

function gi_update_index () {
    mkdir -p $giCache
    curl -sL https://www.gitignore.io/api/list |tr ',' '\n' > $giIndex
}

function gi_get () {
    mkdir -p $giCache
    echo $@ |xargs -I{} bash -c "cat $giCache/{} 2>/dev/null || (curl -sL https://www.gitignore.io/api/{} |tee $giCache/{})"
}

function gi_clean () {
    setopt localoptions rmstarsilent
    [[ -d $giCache ]] && rm -rf $giCache/*
}

function git_stash_fzf () {
    while out=$(git stash list "$@" |
                fzf --ansi --no-sort --reverse --print-query --query="$query"      \
                    --expect=ctrl-m,ctrl-b,del,ctrl-a);
    do
        # Tokenize selection by newline
        selection=("${(f)out}")

        # Keep the query accross fzf calls
        query="$selection[1]"

        # Represents the stash, e.g. stash{1}
        reflog_selector=$(echo "$selection[3]" | cut -d ':' -f 1)

        case "$selection[2]" in
            # enter or ctrl-m is just a diff
            ctrl-m)
                git show --patience --color=always -p "$reflog_selector" | less -R
                ;;
            # ctrl-b checks out the stash as a branch
            ctrl-b)
                sha=$(echo "$selection[3]" | grep -o '[a-f0-9]\{7\}')
                git stash branch "stash-$sha" "$reflog_selector"
                break
                ;;
            ctrl-a)
                sha=$(echo "$selection[3]" | grep -o '[a-f0-9]\{7\}')
                git stash apply
                break
                ;;
            # del will drop the stash
            del)
                git stash drop "$reflog_selector"
                ;;
        esac
    done
}
