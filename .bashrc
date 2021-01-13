# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# basic
export LANG=ja_JP.UTF-8
export PATH=~/bin:~/.local/bin:~/go/bin:$PATH

umask 022                           # 新規作成ファイルのパーミッション644
ulimit -c 0                         # coreファイル作成できないように

# shell option
shopt -s globstar                   # **パス展開
shopt -s cdspell                    # スペルミス補完
shopt -s nocaseglob                 # glob展開時大文字小文字無視

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
alias grep="grep -I"
type vim > /dev/null 2>&1 && alias vi="vim"
type colordiff > /dev/null 2>&1 && alias diff="colordiff -u"

# environment
export EDITOR=vi
export CTAGS="-Rh"
export LV="-lc"
export LESS="-RiM"
export LESSCHARSET=utf-8
export PAGER="less"
export FIGNORE=${FIGNORE}:.svn:.git:.bak
export DIFF_OPTIONS="-uiBw --strip-trailing-cr"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --select-1 --exit-0"

type keychain > /dev/null 2>&1 && keychain -q ~/.ssh/id_ed25519 ~/.ssh/id_rsa > /dev/null 2>&1
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh

if [ -e ~/.asdf ]; then
  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
elif [ -e ~/.anyenv ]; then
  export PATH="~/.anyenv/bin:$PATH"
  eval "$(anyenv init - --no-rehash)"
fi

type hub > /dev/null 2>&1 && eval "$(hub alias -s)"
type direnv > /dev/null 2>&1 && eval "$(direnv hook bash)"

if [ -e ~/google-cloud-sdk ]; then
  source ~/google-cloud-sdk/path.bash.inc
  source ~/google-cloud-sdk/completion.bash.inc
fi

__fzf-ghq() {
    cd $(find $(eval echo $(git config ghq.root)) -maxdepth 1 -type d | fzf --preview 'cat {}/READ*.* 2>/dev/null || ls -C {}')
}

bind -x '"\C-]": "__fzf-ghq"'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
