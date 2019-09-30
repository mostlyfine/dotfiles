# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# basic
LANG=ja_JP.UTF-8
export PATH=~/bin:~/.anyenv/bin:$PATH

umask 022                           # 新規作成ファイルのパーミッション644
ulimit -c 0                         # coreファイル作成できないように
shopt -s globstar                   # **パス展開

# key bind
if [[ -t 0 ]]; then                   # 標準入力がオープンしているときのみ
  stty stop undef                     # CTRL-S無効化
  stty start undef                    # CTRL-Q無効化
  stty werase undef                   # CTRL-W削除
  bind '"\C-w": unix-filename-rubout' # CTLR-W再定義
fi

# prompt
export PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\]]\$ '

# completions
complete -d cd
complete -c man
complete -c wi
complete -c which
complete -c whatis
complete -cf sudo
complete -v unset

# history
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
export HISTIGNORE=?:??:exit

# alias
case "${OSTYPE}" in
  linux*)
    alias ls="ls --color=auto -Fh"
    ;;
  freebsd*|darwin*)
    alias ls="ls -Gw"
    ;;
esac
alias ll="ls -lth"
alias g="git"
alias vi="vim"
alias diff="diff -uiBw --strip-trailing-cr"
alias grep="grep --color=auto -r"

# environment
export EDITOR=vim
export CTAGS="-Rh"
export LV="-lc"
export LESS="-RiM"
export LESSCHARSET=utf-8
export PAGER="less"
export FIGNORE=${FIGNORE}:.svn:.git:.bak
export GREP_COLOR="1;33"

type keychain > /dev/null 2>&1 && keychain -q ~/.ssh/id_rsa ~/.ssh/id_rsa.hobo > /dev/null 2>&1
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh

[ -e ~/.anyenv ] && eval "$(anyenv init - --no-rehash)"
type hub > /dev/null 2>&1 && eval "$(hub alias -s)"
type direnv > /dev/null 2>&1 && eval "$(direnv hook bash)"

peco-select-history() {
    declare l=$(fc -lnr 1 | sed -re "s/^[ \t]+//" | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}

if type peco > /dev/null 2>&1 && [[ -t 1 ]]; then
  bind -x '"\C-r": peco-select-history'
fi
