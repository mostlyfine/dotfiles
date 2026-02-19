export ZDOTDIR=$HOME/dotfiles

typeset -U path PATH
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
