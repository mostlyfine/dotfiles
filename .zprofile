
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
  eval "$(rbenv init - zsh)"
fi

if [ -e ~/.rbenv/completions/rbenv.zsh ] ; then
  source ~/.rbenv/completions/rbenv.zsh
fi

## plenv
if [ -e ~/.plenv ];  then
  eval "$(plenv init - zsh)"
fi

if [ -e ~/.plenv/completions/plenv.zsh ] ; then
  source ~/.plenv/completions/plenv.zsh
fi

## ndenv
if [ -e ~/.ndenv ];  then
  eval "$(ndenv init - zsh)"
fi

if [ -e ~/.ndenv/completions/ndenv.zsh ] ; then
  source ~/.ndenv/completions/ndenv.zsh
fi

## pyenv
if [ -e ~/.pyenv ]; then
  eval "$(pyenv init -)"

  if [ -e ~/.pyenv/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

## goenv
if [ -e ~/.goenv ]; then
  export GOENV_ROOT=~/.goenv
  eval "$(goenv init -)"
fi

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# hub
if type hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi

# keychain
if type keychain > /dev/null 2>&1; then
#   keychain --quiet --ignore-missing --nogui \
  keychain --quiet \
    ~/.ssh/id_rsa \
    ~/.ssh/id_rsa.hobo \

  source ~/.keychain/$HOST-sh
fi

