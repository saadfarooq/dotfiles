if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    $OH_MY_ZSH_HG prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Get the foreground color for argument
function get_color {
  "\[\033[38;5;$1m\]"
}

MONOKAI_MAROON=(get_color 197)
MONOKAI_YELLOW=(get_color 11)
MONOKAI_PURPLE=(get_color 129)
MONOKAI_AQUA=(get_color 45)
MONOKAI_GREEN=(get_color 118)

typeset -Ag FX FG BG

FX=(
    reset     "[00m"
    bold      "[01m" no-bold      "[22m"
    italic    "[03m" no-italic    "[23m"
    underline "[04m" no-underline "[24m"
    blink     "[05m" no-blink     "[25m"
    reverse   "[07m" no-reverse   "[27m"
)

for color in {000..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
done


local p="%{$FX[reset]$FG[243]%}"

local name="%{$FX[reset]$FG[114]%}%n"
local host="%{$FX[reset]$FG[117]%}%m"
local jobs="%1(j.(%{$FX[reset]$FG[197]%}%j job%2(j.s.)${p})-.)"
local time="%{$FX[reset]$FG[215]%}%*"
local dir="%{$FX[reset]$FG[105]%}%~"

local last="%(?..%{$FX[reset]$FG[203]%}%??${p}:)"
local hist="%{$FX[reset]$FG[220]%}%!!"
local priv="%{$FX[reset]$FG[245]%}%#"

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'

# Use zshcontrib's vcs_info to get information about any current version control systems.
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$FX[reset]$FG[082]%}"
zstyle ':vcs_info:*' unstagedstr "%{$FX[reset]$FG[160]%}"
zstyle ':vcs_info:*' formats ":%{$FX[reset]$FG[222]%}%c%u%b"

local vcsi="\${vcs_info_msg_0_}"

PROMPT="${p}(${name}${p}@${host}${p})-${jobs}(${time}${p})-(${dir}${p}${vcsi}${p})
(${last}${p}${hist}${p}:${priv}${p})- %{$FX[reset]%}"

local return_status="%{$FG[119]%}%(?..✘)%{$FX[reset]%}"
RPROMPT="${return_status}%{$FX[reset]%}"