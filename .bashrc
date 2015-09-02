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
alias lv="lv -c -l"
alias g="git"
alias grep="grep --color=auto -r -n"
alias du="du -h"
alias dh="dh -h"
alias dstat-cpu="dstat -tcl --top-cpu-adv"
alias dstat-io="dstat -tclpd --top-io-adv --top-bio-adv"
alias dstat-full="dstat -tclpdsmn"
if type colordiff > /dev/null 2>&1; then
  alias diff="colordiff -Bbiwu"
fi

# environment
export PAGER=/usr/bin/lv
export EDITOR=/usr/bin/vim
export PERLDOC_PAGER=/usr/bin/lv
export LESS="-R"
export CTAGS="-Rh"
export FIGNORE=${FIGNORE}:.svn:.git:.bak
export GREP_COLOR="1;33"

## for ruby
export GEM_HOME=$HOME/.gem/ruby/1.9.3 #/var/lib/gems/1.9
export PATH=$PATH:$GEM_HOME/bin
export RUBYOPT=rubygems
export RSPEC=true

## for rbenv
if [ -f $HOME/.rbenv/completions/rbenv.bash ]; then
  source $HOME/.rbenv/completions/rbenv.bash
fi
export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"

## for perl
export PERL_CPANM_OPT="--local-lib=~/extlib"
export PATH=$PATH:$HOME/extlib/bin
export PERL5LIB=$PERL5LIB:$HOME/extlib/lib/perl5

## for perlbrew
if [ -f $HOME/.perlbrew/etc/bashrc ]; then
  source $HOME/.perlbrew/etc/bashrc
fi
