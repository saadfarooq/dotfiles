# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export ANDROID_HOME=~/opt/android-studio/sdk
alias tufts="ssh -Y sfarooq@linux.cs.tufts.edu"
alias hw="ssh -Y sfarooq@homework.cs.tufts.edu"
alias rascal='expect sshlogin.exp DbLaoXDr rascal96.local'
alias ec2='ssh -Y -i ~/.ssh/interlace.pem ubuntu@dev.dfarooq.com'
PATH="$HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

# Enable the Git branch on prompt
function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
 
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
GREENS="\[\033[0;32m\]"
GREEN="\033[38;5;221m"
# GREEN="\[\033[44;1;31m\]"
BROWN="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
DARK_GRAY="\[\033[1;30m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[1;33m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[1;37m\]"
NO_COLOUR="\[\033[0m\]"
LIGHT_PURPLE="\[\033[0;37m\]"
BCK_BLACK="\[\033[0;40m\]"
BCK_RED="\[\033[0;41m\]"
BCK_GREEN="\[\033[0;42m\]"
BCK_BROWN="\[\033[0;43m\]"
BCK_BLUE="\[\033[0;44m\]"
BCK_PURPLE="\[\033[0;45m\]"
BCK_CYAN="\[\033[0;46m\]"
BCK_LIGHT_GRAY="\[\033[0;47m\]"

MONOKAI_MAROON="\[\033[38;5;197m\]"
MONOKAI_YELLOW="\[\033[38;5;11m\]"
MONOKAI_PURPLE="\[\033[38;5;129m\]"
MONOKAI_AQUA="\[\033[38;5;45m\]"
MONOKAI_GREEN="\[\033[38;5;118m\]"
USER=$MONOKAI_MAROON
PWD=$MONOKAI_AQUA
VCS=$MONOKAI_GREEN
 
PS1="$USER\u@\h$PWD:\w$VCS\$(parse_git_branch)$NO_COLOUR\$ "

# PS1="\[\033[31;41;1m\]\333\262\261\260\[\033[37;41;1m\]\u@\h\[\033[0m\033[31;40m\]\333\262\261\260\[\033[37;40;1m\] \d \$(date +%I:%M:%S%P)\n\[\033[31;40;1m\]\w/\[\033[0m\] "

alias subl="subl --add --command toggle_full_screen"
cd

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Source the rvm initialization script ###
alias rvml='source ~/.rvm/scripts/rvm'
alias c='pygmentize -g'
alias pws='pws --length 16 --seconds 0 \
--filename ~/.config/custom/pws \
--charpool "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890\!~@#$%"'

## Enable autojump
[[ -s ~/.config/custom/autojump.bash ]] && . ~/.config/custom/autojump.bash

# Enable Grunt autocompletion
eval "$(grunt --completion=bash)"

alias geny="~/opt/genymotion/player --vm-name 56269903-0311-4e3c-859a-9679cd71ddfa"