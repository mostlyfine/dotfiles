# -*- sh -*-
export LANG=ja_JP.UTF-8

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
      /var/lib/gems/*/bin(N-/)
      /usr/local/bin(N-/)
      /usr/bin(N-/)
      /usr/sbin(N-/)
      /sbin(N-/)
)

# sudo時のパス設定
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# Rubyライブラリのロードパス設定
typeset -xT RUBYLIB ruby_path
typeset -U ruby_path
ruby_path=(./lib)

# Perlライブラリのロードパス設定
typeset -xT PERL5LIB perl_path
typeset -U perl_path
perl_path=(
  ./lib(N-/)
)

## rbenv
if [ -e ~/.rbenv ];  then
  eval "$(rbenv init -)"
fi

if [ -e ~/.rbenv/completions/rbenv.zsh ] ; then
  source ~/.rbenv/completions/rbenv.zsh
fi

## plenv
if [ -e ~/.plenv ];  then
  eval "$(plenv init -)"
fi

if [ -e ~/.plenv/completions/plenv.zsh ] ; then
  source ~/.plenv/completions/plenv.zsh
fi

## ndenv
if [ -e ~/.ndenv ];  then
  eval "$(ndenv init -)"
fi

if [ -e ~/.ndenv/completions/ndenv.zsh ] ; then
  source ~/.ndenv/completions/ndenv.zsh
fi

## pyenv
if [ -e ~/.pyenv ]; then
  eval "$(pyenv init -)"
fi

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
grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)[^0-9.]*$/\1/')"
export GREP_OPTIONS
GREP_OPTIONS="--binary-files=without-match"
case "$grep_version" in
  1.*|2.[0-4].*|2.5.[0-3])
  ;;
  *)
  GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
  ;;
esac

GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
if grep --help 2>&1 | grep -q -- --exclude-dir; then
  GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
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
alias ll="ls -lh"
alias g="git"
alias r="rails"

