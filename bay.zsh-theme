export VIRTUAL_ENV_DISABLE_PROMPT=yes
virtualenv_default_path=""
# http://sysmagazine.com/posts/145008/
# http://eseth.org/2009/nethack-term.html
# http://aperiodic.net/phil/prompt/
# [[ -w $PWD ]] && infoline+=( ${green} ) || infoline+=( ${yellow} )
# dict
# ip
# init()
# ($COLUMNS-$(printf "${USER}@${HOSTNAME}:${PWDNAME}${PS1_GIT}${PS1_VENV} " | wc -c | tr -d " "))
# date +"%A"
# ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f%%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'
# ioreg -n AppleSmartBattery -r | awk '$1~/ExternalConnected/{gsub("Yes", "+");gsub("No", "%"); print substr($0, length, 1)}'
# activated theme
local theme="monokai"

# special chars
local slambda="λ"
local ssun="✱"
local sgit="±"
local sarrows="»"
local sblow="༅"
local sbigblow="༄"

local sign=$slambda

# colors
local rc="%{$reset_color%}"

local cblue="027"
local cdark="025"
local caqua="051"
local cred="196"
local corange="202"
local cpurple="013"
local cgreen="082"
local clightgreen="076"
local clightblue="111"
local cyellow="229"
local cdarkblue="019"
local cblack="008"

# solarized colors
local s_base="234"
local s_yellow="136"
local s_orange="166"
local s_red="160"
local s_magenta="125"
local s_violet="061"
local s_blue="033"
local s_cyan="037"
local s_green="064"

# monokai
local mk_green="148"
local mk_magenta="197"
local mk_white="253"
local mk_aqua="081"
local mk_violet="141"
local mk_yellow="186"
local mk_orange="208"

case "$theme" in
    "ocean")
        c_user_host=$cblue
        c_privs=$cdark
        c_token=$caqua
        c_token_fail=$corange
        c_branch_name=$cpurple
        c_dirty_flag=$cred
        c_working_dir="white"
        ;;
    "desert")
        c_user_host=$cyellow
        c_privs=$cdark
        c_token=$caqua
        c_token_fail=$corange
        c_branch_name=$cpurple
        c_dirty_flag=$cred
        c_working_dir="white"
        ;;
    "solaire")
        c_user_host=$cgreen
        c_privs=$cdark
        c_token=$cdarkblue
        c_token_fail=$corange
        c_branch_name=$cpurple
        c_dirty_flag=$cred
        c_working_dir=$cblack
        ;;
    "monokai")
        c_user_host=$mk_green
        c_privs=$mk_white
        c_token=$mk_aqua
        c_token_fail=$mk_yellow
        c_branch_name=$mk_violet
        c_dirty_flag=$mk_magenta
        c_working_dir=$mk_orange
        ;;
    "solarized")
        c_user_host=$s_cyan
        c_privs=$s_yellow
        c_token=$s_violet
        c_token_fail=$s_red
        c_branch_name=$s_green
        c_dirty_flag=$s_orange
        c_working_dir=$s_blue
        ;;
esac

# parts
# local sign="%{%B%F{$mk_white}%}$sbigblow $sblow$sbigblow $sblow $rc %{%B%F{$mk_magenta}%}$slambda $rc"
# local sign="$sbigblow $sblow$sbigblow $sblow $slambda $rc"
#
# local user="%{%B%F{$c_user_host}%}%n$rc"
# local host="%{%B%F{$c_user_host}%}%m$rc"
# local privs="(%{%B%F{$c_privs}%}%#% $rc)"
# # color depends on return code
# local token="%(?,%{%B%F{$c_token}%}$sign$rc,%{%B%F{$c_token_fail}%}$sign$rc)"
# local wdir="%{%B%F{$c_working_dir}%}%d$rc"







ZSH_THEME_GIT_PROMPT_PREFIX="[ %{%B%F{$c_branch_name}%}$sgit "
ZSH_THEME_GIT_PROMPT_SUFFIX="$rc"
# replaced by git_prompt_status
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{%B%F{$c_dirty_flag}%}$ssun%{%B%F{$c5}%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{%B%F{green}%} ✚ $rc"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{%B%F{blue}%} ✎ $rc"
ZSH_THEME_GIT_PROMPT_DELETED="%{%B%F{red}%} ✖ $rc"
ZSH_THEME_GIT_PROMPT_RENAMED="%{%B%F{magenta}%} ⇆ $rc"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{%B%F{yellow}%} ⌥ $rc"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{%B%F{cyan}%} � $rc"



# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{%B%F{green}%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{%B%F{yellow}%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{%B%F{red}%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{%B%F{cyan}%}"
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function echo_git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$DAYS" -gt 1 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$HOURS" -gt 4 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo "$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%} ]"
            elif [ "$MINUTES" -gt 60 ]; then
                echo "$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%} ]"
            else
                echo "$COLOR${MINUTES}m%{$reset_color%} ]"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "$COLOR~ ]"
        fi
    fi
}

# check default path
if [[ $(basename "$VIRTUAL_ENV") == "" ]]
then
    source /Users/mbayer/Workspace/Envs/python2.7.5/bin/activate
fi

function echo_virtualenv_name {
    virtualenv_name=$(basename "$VIRTUAL_ENV")
    if [[ "$virtualenv_name" != "" ]]; then
        echo "[ %{%B%F{cyan}%}$virtualenv_name$rc ]"
    fi

    # [ $VIRTUAL_ENV ] && echo "[ %{%B%F{cyan}%}"`basename $VIRTUAL_ENV`"$rc]"
}

function echo_time() {
    echo "%{%B%F{white}%}"`date +%H:%M:%S`
}

function echo_cmds() {
    echo "%{%B%F{$mk_yellow}%}%!%{%f%k%b%}"
}

function echo_battery() {
    # get the battery status as int
    battery=`ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.0f"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'`

    # determine how many full bars to draw
    bars=0
    if [[ $battery == 100 ]]; then
        bars=10
    elif [[ $battery -gt 90 ]]; then
        bars=9
    elif [[ $battery -gt 80 ]]; then
        bars=8
    elif [[ $battery -gt 70 ]]; then
        bars=7
    elif [[ $battery -gt 60 ]]; then
        bars=6
    elif [[ $battery -gt 50 ]]; then
        bars=5
    elif [[ $battery -gt 40 ]]; then
        bars=4
    elif [[ $battery -gt 30 ]]; then
        bars=3
    elif [[ $battery -gt 20 ]]; then
        bars=2
    elif [[ $battery -gt 10 ]]; then
        bars=1
    elif [[ $battery -lt 10 ]]; then
        bars=0
    fi

    # fill
    full="${(l:$bars::|:)}"
    empty="${(l:10-$bars::|:)}"

    echo "%{%B%F{green}%}$full%{%B%F{red}%}$empty$rc"
}

function echo_user() {
    echo "%{%B%F{$c_user_host}%}%n$rc"
}

function echo_host() {
    echo "%{%B%F{$c_user_host}%}%m$rc"
}

function echo_user_host() {
    local user="%{%B%F{$c_user_host}%}%n$rc"
    local host="%{%B%F{$c_user_host}%}%m$rc"
    local privs="(%{%B%F{$c_privs}%}%#% $rc)"

    echo "[ $user$privs$host ]"
}

function echo_pwd() {
    if [[ -w $PWD ]]; then
        echo "[ %{%B%F{$c_working_dir}%}%d$rc ]"
    else
        echo "[ %{%B%F{red}%}%d$rc ]"
    fi
}

function echo_prefix () {
    # color depends on return code
    local token="λ"
    echo "%(?,%{%B%F{$c_token}%}$token$rc,%{%B%F{$c_token_fail}%}$token$rc)"
}

function echo_top_left_corner() {
    echo "╔══"
}

function echo_top_right_corner() {
    # echo "══╗"
    echo "╗"
}

function echo_git() {
    git_prompt_info_part=($(git_prompt_info))
    git_prompt_status_part=($(git_prompt_status))
    git_time_since_commit_part=$(echo_git_time_since_commit)

    echo "$git_prompt_info_part$git_prompt_status_part$git_time_since_commit_part"
}

function echo_filler() {
    # set -A topline
    topline=()
    top_left_corner=$(echo_top_left_corner)
    if [[ "$virtualenv_name" != "" ]]; then
        topline+=("$(echo_top_left_corner)")
    fi
    top_right_corner=$(echo_top_right_corner)
    if [[ "$top_right_corner" != "" ]]; then
        topline+=("$(echo_top_right_corner)")
    fi
    user_host=$(echo_user_host)
    if [[ "$user_host" != "" ]]; then
        topline+=("$(echo_user_host)")
    fi
    _pwd=$(echo_pwd)
    if [[ "$_pwd" != "" ]]; then
        topline+=("$(echo_pwd)")
    fi
    virtualenv_name=$(echo_virtualenv_name)
    if [[ "$virtualenv_name" != "" ]]; then
        topline+=("$(echo_virtualenv_name)")
    fi
    _git=$(echo_git)
    if [[ "$_git" != "" ]]; then
        topline+=("$(echo_git)")
    fi

    # echo $#topline
    # for (( i=1; i<=$#topline; i++ )); do
    #     echo $i
    #     echo $toppine[$i]
    # done


    i_width=${(S)topline//\%\{*\}\%\}} # search-and-replace color escapes
    # echo $i_width
    i_width=${#${(%)i_width}} # expand all escapes and count the chars
    i_len=$#topline
    strange=0
    if [[ "$i_len" == 3 ]]; then
        strange=-3
    elif [[ "$i_len" == 4 ]]; then
        strange=0
    elif [[ "$i_len" == 5 ]]; then
        strange=3
    fi
    # i_width=${topline}
    # print $i_len
    xmod=$(( $i_len % 2 ))

    # i_filler=$(( $COLUMNS - $i_width + $i_len - $strange + 1))
    i_filler=$(( $COLUMNS - $i_width + $i_len*3 + $strange))
    # echo "$COLUMNS - $i_width + $i_len"
    # echo $i_filler
    # echo $i_filler
    echo "${(l:$i_filler::═:)}"
    # echo "$COLUMNS"
    # echo "$i_width"
    # echo "$i_filler"

    # local topline_width
    # topline_width=${#${(%)topline}}
    # topline_width=${(S)$topline//\%\{*\%\}}
    # topline_width=${(S)$topline//\%\{*\}\%\}}
    # %{$fg[white]%}
    # %{%B%F{$c_token}%}

    # i_width=${#${(%)i_width}}
    # local i_filler

    # echo $i_width

}


# assemble the prompt
top_left_corner_part=$(echo_top_left_corner)
user_host_part=$(echo_user_host)
pwd_part=$(echo_pwd)
virtualenv_name_part=$(echo_virtualenv_name)
# git_prompt_info_part=($(git_prompt_info))
# git_prompt_status_part=($(git_prompt_status))
# git_time_since_commit_part=$(echo_git_time_since_commit)
git_part=$(echo_git)
top_right_corner_part=$(echo_top_right_corner)

# # array holding the top line
# set -A topline
# topline+=($top_left_corner_part)
# topline+=($user_host_part)
# topline+=($pwd_part)
# topline+=($(echo_virtualenv_name))
# topline+=($git_part)
# # topline+=($top_right_corner_part)


LENGTH=${#user_host}


# $top_left_corner_part$user_host_part$pwd_part$virtualenv_name_part$git_prompt_info_part$git_prompt_status_part$git_time_since_commit_part
PROMPT=$'
$top_left_corner_part$user_host_part$pwd_part$(echo_virtualenv_name)$(git_prompt_info)$(git_prompt_status)$(echo_git_time_since_commit)$(echo_filler)$top_right_corner_part
╚══════► $(echo_prefix) '

local sblow="༅"
local sbigblow="༄"


PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '

RPROMPT='[ $(echo_time) $(echo_battery) $(echo_cmds) ]═════╝'

