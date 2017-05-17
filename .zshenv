# -*- sh -*-
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# パスの設定
typeset -U path

path=(# システム用
      /bin(N-/)
      $HOME/bin(N-/)
      $HOME/local/bin(N-/)
      $HOME/.gem/ruby/*/bin(N-/)
      $HOME/.rbenv/bin(N-/)
      $HOME/.plenv/bin(N-/)
      $HOME/.pyenv/bin(N-/)
      $HOME/.ndenv/bin(N-/)
      $HOME/.goenv/bin(N-/)
      $HOME/.goenv/shims(N-/)
      node_modules/.bin(N-/)
      /var/lib/gems/*/bin(N-/)
      /usr/local/bin(N-/)
      /usr/local/sbin(N-/)
      /usr/bin(N-/)
      /usr/sbin(N-/)
      /sbin(N-/)
)

# sudo時のパス設定
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# ページャの設定
if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# lvの設定
export LV="-c -l"

if [ "$PAGER" != "lv" ]; then
  alias lv="$PAGER"
fi

# lessの設定
export LESS="-R"

# CTAGの設定
export CTAGS="-Rh"

# gitの設定
export GIT_MERGE_AUTOEDIT=no

# grepの設定
if type ggrep > /dev/null 2>&1; then
  alias grep=ggrep
fi

# エディタの設定
export EDITOR=vim
if ! type vim > /dev/null 2>&1; then
  alias vim=vi
fi

# エイリアスの設定
if type colordiff > /dev/null 2>&1; then
  alias diff="colordiff -Bbiwu"
fi

case "${OSTYPE}" in
  linux*)
    alias ls="ls --color=auto -Fh"
    ;;
  *)
    alias ls="ls -Gw"
    ;;
esac
alias ll="ls -lth"
if type hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi
alias g="git"
alias r="rails"
alias vi="vim"

alias dstat-cpu="dstat -tcl --top-cpu-adv"
alias dstat-io="dstat -tclpd --top-io-adv --top-bio-adv"
alias dstat-full="dstat -tclpdsmn"
