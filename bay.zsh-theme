# activated theme
local theme="solarized"

# special chars
local slambda="λ"
local ssun="✱"
local sgit="±"
local sarrows="»"

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
local sign="$sarrows$sarrows$sarrows λ"

local user="%{$FG[$c_user_host]%}%n$rc"
local host="%{$FG[$c_user_host]%}%m$rc"
local privs="(%{$FG[$c_privs]%}%#% $rc)"
local token="%(?,%{$FG[$c_token]%}$sign$rc,%{$FG[$c_token_fail]%}$sign$rc)"
local wdir="%{$FG[$c_working_dir]%}%d$rc"

ZSH_THEME_GIT_PROMPT_PREFIX="$rc [ %{$FG[$c_branch_name]%} $sgit "
ZSH_THEME_GIT_PROMPT_SUFFIX=" $rc]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$c_dirty_flag]%}$ssun%{$FG[$c5]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# assemble
PROMPT=$'$user$privs$host [$wdir] $(git_prompt_info)
 $token '

# additional signs
local sflash="⚡"
local sangle="❯"
local splus="✚"
local scircle="✹"
local sx="✖"
local sarrow="➜"
local sminux="═"
local sstar="✭"
local splane="✈"
local ssx="✂"
local sarrowfat="➦"
local scx="✗"
local slx="✖"
local ssomething="☁"
local sumbrella="☂"
local s="♆"
local sgirl="♀"
local sboy="♁"
local spin="♐"
local s="♇"
local s="♈"
local s="♉"
local s="♚"
local s="♛"
local s="♜"
local s="♝"
local s="♞"
local s="♟"
local s="♠"
local s="♣"
local s="⚒"
local s="⚑"
local s="⚐"
local s="♺"
local s="♻"
local s="♼"
local s="ǀ"
local s="ǁ"
local s="ǂ"
local s="ĭ"
local s="Ť"
local s="Ŧ"

# More symbols to choose from:
# ☀ ✹ ☄ ♆ ♀ ♁ ♐ ♇ ♈ ♉ ♚ ♛ ♜ ♝ ♞ ♟ ♠ ♣ ⚢ ⚲ ⚳ ⚴ ⚥ ⚤ ⚦ ⚒ ⚑ ⚐ ♺ ♻ ♼ ☰ ☱ ☲ ☳ ☴ ☵ ☶ ☷
# ✡ ✔ ✖ ✚ ✱ ✤ ✦ ❤ ➜ ➟ ➼ ✂ ✎ ✐ ⨀ ⨁ ⨂ ⨍ ⨎ ⨏ ⨷ ⩚ ⩛ ⩡ ⩱ ⩲ ⩵  ⩶ ⨠ 
# ⬅ ⬆ ⬇ ⬈ ⬉ ⬊ ⬋ ⬒ ⬓ ⬔ ⬕ ⬖ ⬗ ⬘ ⬙ ⬟  ⬤ 〒 ǀ ǁ ǂ ĭ Ť Ŧ
# ⑊ Ⓞ ⑃ ⓜ ⑁ ⓧ ⑂ ⓡ ⑄ ♒ ⓤ 𝝙




#################################################
# wedisagree git since
# # On a mac with snow leopard, for nicer terminal colours:
#
# # - Install SIMBL: http://www.culater.net/software/SIMBL/SIMBL.php
# # - Download'Terminal-Colours': http://bwaht.net/code/TerminalColours.bundle.zip
# # - Place that bundle in ~/Library/Application\ Support/SIMBL/Plugins (create that folder if it doesn't exist)
# # - Open Terminal preferences. Go to Settings -> Text -> More
# # - Change default colours to your liking.
# # 
# # Here are the colours from Textmate's Monokai theme:
# # 
# # Black: 0, 0, 0
# # Red: 229, 34, 34
# # Green: 166, 227, 45
# # Yellow: 252, 149, 30
# # Blue: 196, 141, 255
# # Magenta: 250, 37, 115
# # Cyan: 103, 217, 240
# # White: 242, 242, 242
#
# # Thanks to Steve Losh: http://stevelosh.com/blog/2009/03/candy-colored-terminal/
#
# # The prompt
#
# PROMPT='%{$fg[magenta]%}[%c] %{$reset_color%}'
#
# # The right-hand prompt
#
# RPROMPT='${time} %{$fg[magenta]%}$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}$(git_prompt_ahead)%{$reset_color%}'
#
# # Add this at the start of RPROMPT to include rvm info showing ruby-version@gemset-name
# # %{$fg[yellow]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%} 
#
# # local time, color coded by last return code
# time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
# time_disabled="%{$fg[green]%}%*%{$reset_color%}"
# time=$time_enabled
#
# ZSH_THEME_GIT_PROMPT_PREFIX=" ☁  %{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ☂" # Ⓓ
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭" # ⓣ
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ☀" # Ⓞ
#
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✚" # ⓐ ⑃
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ⚡"  # ⓜ ⑁
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖" # ⓧ ⑂
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➜" # ⓡ ⑄
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ♒" # ⓤ ⑊
# ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%} 𝝙"
#
# # More symbols to choose from:
# # ☀ ✹ ☄ ♆ ♀ ♁ ♐ ♇ ♈ ♉ ♚ ♛ ♜ ♝ ♞ ♟ ♠ ♣ ⚢ ⚲ ⚳ ⚴ ⚥ ⚤ ⚦ ⚒ ⚑ ⚐ ♺ ♻ ♼ ☰ ☱ ☲ ☳ ☴ ☵ ☶ ☷
# # ✡ ✔ ✖ ✚ ✱ ✤ ✦ ❤ ➜ ➟ ➼ ✂ ✎ ✐ ⨀ ⨁ ⨂ ⨍ ⨎ ⨏ ⨷ ⩚ ⩛ ⩡ ⩱ ⩲ ⩵  ⩶ ⨠ 
# # ⬅ ⬆ ⬇ ⬈ ⬉ ⬊ ⬋ ⬒ ⬓ ⬔ ⬕ ⬖ ⬗ ⬘ ⬙ ⬟  ⬤ 〒 ǀ ǁ ǂ ĭ Ť Ŧ
#
# # Determine if we are using a gemset.
# function rvm_gemset() {
#     GEMSET=`rvm gemset list | grep '=>' | cut -b4-`
#     if [[ -n $GEMSET ]]; then
#         echo "%{$fg[yellow]%}$GEMSET%{$reset_color%}|"
#     fi 
# }
#
# # Determine the time since last commit. If branch is clean,
# # use a neutral color, otherwise colors will vary according to time.
# function git_time_since_commit() {
#     if git rev-parse --git-dir > /dev/null 2>&1; then
#         # Only proceed if there is actually a commit.
#         if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
#             # Get the last commit.
#             last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
#             now=`date +%s`
#             seconds_since_last_commit=$((now-last_commit))
#
#             # Totals
#             MINUTES=$((seconds_since_last_commit / 60))
#             HOURS=$((seconds_since_last_commit/3600))
#            
#             # Sub-hours and sub-minutes
#             DAYS=$((seconds_since_last_commit / 86400))
#             SUB_HOURS=$((HOURS % 24))
#             SUB_MINUTES=$((MINUTES % 60))
#             
#             if [[ -n $(git status -s 2> /dev/null) ]]; then
#                 if [ "$MINUTES" -gt 30 ]; then
#                     COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
#                 elif [ "$MINUTES" -gt 10 ]; then
#                     COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
#                 else
#                     COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
#                 fi
#             else
#                 COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#             fi
#
#             if [ "$HOURS" -gt 24 ]; then
#                 echo "($(rvm_gemset)$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
#             elif [ "$MINUTES" -gt 60 ]; then
#                 echo "($(rvm_gemset)$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
#             else
#                 echo "($(rvm_gemset)$COLOR${MINUTES}m%{$reset_color%}|"
#             fi
#         else
#             COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#             echo "($(rvm_gemset)$COLOR~|"
#         fi
#     fi
# }
# #################################################
#
#
# #################################################
#
#
# #################################################
#
#
# #################################################
#
#
#
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
# #################################################
