# .bashrc
LANG=ja_JP.UTF-8

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

umask 022     # 新規作成ファイルのパーミッション644
ulimit -c 0   # coreファイル作成できないように

# completions
complete -d cd
complete -c man
complete -c wi
complete -c which
complete -c whatis
complete -c sudo
complete -v unset

# alias
case "${OSTYPE}" in
  linux*)
    alias ls="ls --color=auto -Fh"
    ;;
  freebsd*|darwin*)
    alias ls="ls -Gw"
    ;;
esac
alias ll="ls -lh"
alias g="git"
alias vi="vim"
alias grep="grep --color=auto -r"
alias du="du -h"
alias dh="dh -h"
alias dstat-cpu="dstat -tcl --top-cpu-adv"
alias dstat-io="dstat -tclpd --top-io-adv --top-bio-adv"
alias dstat-full="dstat -tclpdsmn"
if type colordiff > /dev/null 2>&1; then
  alias diff="colordiff -Bbiwu"
fi

# environment
if type lv > /dev/null 2>&1; then
  alias lv="lv -lc"
else
  alias lv="/usr/bin/less"
fi

if type vim > /dev/null 2>&1; then
  export EDITOR=/usr/bin/vim
fi

if type hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi

export PAGER=lv
export PERLDOC_PAGER=lv
export LESS="-R"
export CTAGS="-Rh"
export FIGNORE=${FIGNORE}:.svn:.git:.bak
export GREP_COLOR="1;33"

## rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

if [ -f $HOME/.rbenv/completions/rbenv.bash ]; then
  source $HOME/.rbenv/completions/rbenv.bash
fi

## plenv
if [ -e $HOME/.plenv ]; then
  export PATH=$HOME/.plenv/bin:$PATH
  eval "$(plenv init -)"
fi

if [ -e $HOME/.plenv/completions/plenv.bash ]; then
  source $HOME/.plenv/completions/plenv.bash
fi

## ndenv
if [ -e $HOME/.ndenv ];  then
  export PATH=$HOME/.ndenv/bin:$PATH
  eval "$(ndenv init -)"
fi

if [ -e $HOME/.ndenv/completions/ndenv.bash ]; then
  source $HOME/.ndenv/completions/ndenv.bash
fi
