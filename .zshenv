export ZDOTDIR=$HOME/dotfiles

umask 002

typeset -U path cdpath fpath manpath
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
)

export LANG=ja_JP.UTF-8
export EDITOR=vim
export CTAGS="-Rh"
export LV="-c -l"
export LESS="-RiMFX"
export LESSCHARSET=utf-8
export PAGER="less"
export DIFF_OPTIONS="-uiBw --strip-trailing-cr"
export FZF_CTRL_T_COMMAND=
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi --select-1 --exit-0"
export RIPGREP_CONFIG_PATH=$HOME/dotfiles/.ripgreprc
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

((${+commands[brew]})) && export HOMEBREW_PREFIX=$(brew --prefix)

((${+commands[mise]})) > /dev/null 2>&1 && eval "$(mise activate zsh)"

if (( ${+commands[keychain]} )) && [ -f ~/.keychain/${HOST:-$(hostname)}-sh ]; then
  keychain -q ~/.ssh/id_ed25519 ~/.ssh/id_rsa > /dev/null 2>&1
  source ~/.keychain/${HOST:-$(hostname)}-sh
fi

if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]]; then
  ln -snf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
  export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
fi
