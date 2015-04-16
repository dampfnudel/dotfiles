#   ▀█████████▄     ▄████████ ▄██   ▄    ▄███████▄     ▄████████    ▄█    █▄       ▄████████  ▄████████
#     ███    ███   ███    ███ ███   ██▄ ██▀     ▄██   ███    ███   ███    ███     ███    ███ ███    ███
#     ███    ███   ███    ███ ███▄▄▄███       ▄███▀   ███    █▀    ███    ███     ███    ███ ███    █▀
#    ▄███▄▄▄██▀    ███    ███ ▀▀▀▀▀▀███  ▀█▀▄███▀▄▄   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄▄██▀ ███
#   ▀▀███▀▀▀██▄  ▀███████████ ▄██   ███   ▄███▀   ▀ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀▀▀   ███
#     ███    ██▄   ███    ███ ███   ███ ▄███▀                ███   ███    ███   ▀███████████ ███    █▄
#     ███    ███   ███    ███ ███   ███ ███▄     ▄█    ▄█    ███   ███    ███     ███    ███ ███    ███
#   ▄█████████▀    ███    █▀   ▀█████▀   ▀████████▀  ▄████████▀    ███    █▀      ███    ███ ████████▀
#                                                                                 ███    ███

# ASCII-Art credits: http://patorjk.com/software/taag/#p=display&f=Delta%20Corps%20Priest%201&t=.zshrc

# features include:
# - different color themes
# - responsiv filler of the first line
# - a token for each weekday
# - show privileges
# - show if pwd is writable
# - git infos (branchname, status, colored time since last commit)
# - time
# - battery status
# - amount of commands entered
# - color output of the last commands returncode
# - ps2 shows the reason for continuation

# disable the default virtualenv info
export VIRTUAL_ENV_DISABLE_PROMPT=yes
# activated theme
local theme="monokai"
local theme="solarized"
local theme="inkpot"

# colors
local rc="%{$reset_color%}"

# set the colors according to the theme
case "$theme" in
    "inkpot")
        local inkpot_violet="105"
        local inkpot_cyan="117"
        local inkpot_blue="031"
        local inkpot_orange="172"
        local inkpot_magenta="213"
        local inkpot_yellow="222"
        local inkpot_brown="181"
        local inkpot_green="122"

        local c_user_host="%{%B%F{$inkpot_violet}%}"
        local c_privs="%{%B%F{$inkpot_cyan}%}"
        local c_pwd="%{%B%F{$inkpot_magenta}%}"
        local c_virtual_env="%{%B%F{$inkpot_yellow}%}"
        local c_git="%{%B%F{$inkpot_blue}%}"
        local c_token="%{%B%F{$inkpot_orange}%}"
        local c_time="%{%B%F{$inkpot_green}%}"
        local c_cmds="%{%B%F{$inkpot_brown}%}"
        ;;
    "monokai")
        local monokai_green="148"
        local monokai_magenta="197"
        local monokai_white="253"
        local monokai_cyan="081"
        local monokai_violet="141"
        local monokai_yellow="186"
        local monokai_orange="208"

        local c_user_host="%{%B%F{$monokai_green}%}"
        local c_privs="%{%B%F{$monokai_white}%}"
        local c_pwd="%{%B%F{$monokai_orange}%}"
        local c_virtual_env="%{%B%F{$monokai_cyan}%}"
        local c_git="%{%B%F{$monokai_violet}%}"
        local c_token="%{%B%F{$monokai_cyan}%}"
        local c_time="%{%B%F{white}%}"
        local c_cmds="%{%B%F{$monokai_yellow}%}"
        ;;
    "solarized")
        local solarized_base="234"
        local solarized_yellow="136"
        local solarized_orange="166"
        local solarized_red="160"
        local solarized_magenta="125"
        local solarized_violet="061"
        local solarized_blue="033"
        local solarized_cyan="037"
        local solarized_green="064"

        local c_user_host="%{%B%F{$solarized_cyan}%}"
        local c_privs="%{%B%F{$solarized_yellow}%}"
        local c_pwd="%{%B%F{$solarized_blue}%}"
        local c_virtual_env="%{%B%F{$solarized_orange}%}"
        local c_git="%{%B%F{$solarized_magenta}%}"
        local c_token="%{%B%F{$solarized_green}%}"
        local c_time="%{%B%F{$solarized_violet}%}"
        local c_cmds="%{%B%F{$solarized_red}%}"
        ;;
esac

# git status variables
local ZSH_THEME_GIT_PROMPT_PREFIX="[ $c_git± "
local ZSH_THEME_GIT_PROMPT_SUFFIX="$rc"
# replaced by git_prompt_status
# local ZSH_THEME_GIT_PROMPT_DIRTY=" %{%B%F{$c_dirty_flag}%}$ssun%{%B%F{$c5}%}"
local ZSH_THEME_GIT_PROMPT_DIRTY=""
local ZSH_THEME_GIT_PROMPT_CLEAN=""

local ZSH_THEME_GIT_PROMPT_ADDED="$c_git ✚ $rc"
local ZSH_THEME_GIT_PROMPT_MODIFIED="$c_git ✎ $rc"
local ZSH_THEME_GIT_PROMPT_DELETED="$c_git ✖ $rc"
local ZSH_THEME_GIT_PROMPT_RENAMED="$c_git ⇆ $rc"
local ZSH_THEME_GIT_PROMPT_UNMERGED="$c_git ⌥ $rc"
local ZSH_THEME_GIT_PROMPT_UNTRACKED="$c_git � $rc"

# Colors vary depending on time lapsed.
local ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{%B%F{green}%}"
local ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{%B%F{yellow}%}"
local ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{%B%F{red}%}"
local ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{%B%F{cyan}%}"

function echo_git_time_since_commit() {
    # determine the time since last commit. If branch is clean,
    # use a neutral color, otherwise colors will vary according to time.
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # get the last commit.
            last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
            now=$(date +%s)
            seconds_since_last_commit=$((now-last_commit))

            # totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # sub-hours and sub-minutes
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
                echo " $COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%} ]"
            elif [ "$MINUTES" -gt 60 ]; then
                echo " $COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%} ]"
            else
                echo " $COLOR${MINUTES}m%{$reset_color%} ]"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo " $COLOR~ ]"
        fi
    fi
}

function echo_virtualenv_name {
    virtualenv_name=$(basename "$VIRTUAL_ENV")
    if [[ "$virtualenv_name" != "" ]]; then
            echo "[ $c_virtual_env$virtualenv_name$rc ]"
        fi
    }

function echo_time() {
    # show sun or moon
    if [[ $(date +%H) > 17 ]]; then
        local dok="☾"
    else
        local dok="☀"
    fi

    echo $c_time$dok $(date +%H:%M:%S)
}

function echo_cmds() {
    echo "$c_cmds%!%{%f%k%b%}"
}

function echo_battery() {
    # get the battery status as int
    local battery=`ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.0f"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'`

    # determine how many full bars to draw
    local bars=0
    if [[ $battery == 100 ]]; then
        local bars=10
    elif [[ $battery -gt 90 ]]; then
        local bars=9
    elif [[ $battery -gt 80 ]]; then
        local bars=8
    elif [[ $battery -gt 70 ]]; then
        local bars=7
    elif [[ $battery -gt 60 ]]; then
        local bars=6
    elif [[ $battery -gt 50 ]]; then
        local bars=5
    elif [[ $battery -gt 40 ]]; then
        local bars=4
    elif [[ $battery -gt 30 ]]; then
        local bars=3
    elif [[ $battery -gt 20 ]]; then
        local bars=2
    elif [[ $battery -gt 10 ]]; then
        local bars=1
    elif [[ $battery -lt 10 ]]; then
        local bars=0
    fi

    # fill
    local full="${(l:$bars::|:)}"
    local empty="${(l:10-$bars::|:)}"

    echo "%{%B%F{green}%}$full%{%B%F{red}%}$empty$rc"
}

function echo_user() {
    echo "$c_user_host%n$rc"
}

function echo_host() {
    echo "$c_user_host%m$rc"
}

function echo_user_host() {
    local user="$c_user_host%n$rc"
    local host="$c_user_host%m$rc"
    local privs="($c_privs%#% $rc)"

    echo "[ $user$privs$host ]"
}

function echo_pwd() {
    if [[ -w $PWD ]]; then
        echo "[ $c_pwd%d$rc ]"
    else
        echo "[ %{%B%F{red}%}%d$rc ]"
    fi
}

function echo_token() {
    # every weekday is mapped to a token
    # color depends on return code
    local weekday=$(date +"%A")

    local token="λ"

    case "$weekday" in
        "Montag")
            local token="☹"
            ;;
        "Dienstag")
            local token="༄༅"
            ;;
        "Mittwoch")
            local token="☮"
            # local token="⚛"
            ;;
        "Donnerstag")
            local token="☯"
            # local token="∞"
            # local token="☘"
            # local token="♡"
            ;;
        "Freitag")
            local token="♕"
            ;;
        "Samstag")
            local token="λ"
            ;;
        "Sonntag")
            local token="✱"
            ;;
    esac

    echo "%(?,$c_token$token$rc,%{%B%F{red}%}☠$rc)"
}

function echo_top_left_corner() {
    echo "╔══"
}

function echo_top_right_corner() {
    echo "══╗"
}

function echo_bottom_left_corner() {
    echo "╚══════⫸"
}

function echo_bottom_right_corner() {
    echo "════╝"
}

# function echo_bits() {
#     echo "⎍"
#     echo "⊓"
# }
#
# function echo_masonry() {
#     echo "☰☱☲☳☴☵☶☷"
#     echo "∴∵∶∷"
#     echo "⋰⋱"
#     echo "░"
#     echo "▒"
#     echo "▓"
# }

function echo_git() {
    git_prompt_info_part=($(git_prompt_info))
    git_prompt_status_part=($(git_prompt_status))
    git_time_since_commit_part=$(echo_git_time_since_commit)

    echo "$git_prompt_info_part$git_prompt_status_part$git_time_since_commit_part"
}

function echo_infoline() {
    # TODO rewrite this mess
    arrangement=-3
    topline=()

    top_left_corner_part=$(echo_top_left_corner)
    if [[ "$virtualenv_name_part" != "" ]]; then
        topline+=("$top_left_corner_part")
    fi
    user_host_part=$(echo_user_host)
    if [[ "$user_host_part" != "" ]]; then
        topline+=("$user_host_part")
    fi
    pwd_part=$(echo_pwd)
    if [[ "$pwd_part" != "" ]]; then
        topline+=("$pwd_part")
    fi
    virtualenv_name_part=$(echo_virtualenv_name)
    if [[ "$virtualenv_name_part" != "" ]]; then
        arrangement=$arrangement+3
        topline+=("$virtualenv_name_part")
    fi
    git_part=$(echo_git)
    if [[ "$git_part" != "" ]]; then
        arrangement=$arrangement+2
        topline+=("$git_part")
    fi
    top_right_corner_part=$(echo_top_right_corner)
    if [[ "$top_right_corner_part" != "" ]]; then
        topline+=("$top_right_corner_part")
    fi

    infoline="$top_left_corner_part$user_host_part$pwd_part$virtualenv_name_part$(git_prompt_info)$(git_prompt_status)$(echo_git_time_since_commit)"

    i_width=${(S)topline//\%\{*\}\%\}} # search-and-replace color escapes
    i_width=${#${(%)i_width}} # expand all escapes and count the chars
    i_len=$#topline

    i_filler=$(($COLUMNS - $i_width + $i_len*3 + $arrangement))

    if [[ $i_filler < 0 ]]; then
        arrangement=-3
        topline=()

        top_left_corner_part=$(echo_top_left_corner)
        if [[ "$virtualenv_name_part" != "" ]]; then
            topline+=("$top_left_corner_part")
        fi
        user_host_part=$(echo_user_host)
        if [[ "$user_host_part" != "" ]]; then
            topline+=("$user_host_part")
        fi
        pwd_part=$(echo_pwd)
        if [[ "$pwd_part" != "" ]]; then
            topline+=("$pwd_part")
        fi

        i_width=${(S)topline//\%\{*\}\%\}} # search-and-replace color escapes
        i_width=${#${(%)i_width}} # expand all escapes and count the chars
        i_len=$#topline
        i_filler=$(($COLUMNS - $i_width + $i_len*3 + $arrangement))

        infoline="$top_left_corner_part$user_host_part$pwd_part${(l:$i_filler::═:)}$top_right_corner_part\n╠══$virtualenv_name_part$(git_prompt_info)$(git_prompt_status)$(echo_git_time_since_commit)"

        arrangement=-3
        topline=()
        virtualenv_name_part=$(echo_virtualenv_name)
        if [[ "$virtualenv_name_part" != "" ]]; then
            arrangement=$arrangement+3
            topline+=("$virtualenv_name_part")
        fi
        git_part=$(echo_git)
        if [[ "$git_part" != "" ]]; then
            arrangement=$arrangement+2
            topline+=("$git_part")
        fi
        top_right_corner_part=$(echo_top_right_corner)
        if [[ "$top_right_corner_part" != "" ]]; then
            topline+=("$top_right_corner_part")
        fi
        i_width=${(S)topline//\%\{*\}\%\}} # search-and-replace color escapes
        i_width=${#${(%)i_width}} # expand all escapes and count the chars
        i_len=$#topline
        i_filler=$(($COLUMNS - $i_width + $i_len*3 + $arrangement - 2))

        echo "$infoline${(l:$i_filler:: :)}║"
    else
        echo "$infoline${(l:$i_filler::═:)}$top_right_corner_part"
    fi

    firstline="$infoline$top_right_corner_part"
}

# assemble the prompt
PROMPT=$'
$(echo_infoline)
$(echo_bottom_left_corner) $(echo_token) '

RPROMPT='[ $(echo_time) $(echo_battery) $(echo_cmds) ]$(echo_bottom_right_corner)'

PS2='[ %{%B%F{yellow}%}%_$rc ]'

