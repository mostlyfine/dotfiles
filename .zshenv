umask 002

typeset -U path cdpath fpath manpath

export ZDOTDIR=$HOME/dotfiles
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
export RIPGREP_CONFIG_PATH=$ZDOTDIR/.ripgreprc
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
# ref: https://www.nerdfonts.com/cheat-sheet
export LF_ICONS="di=:fi=:ln=:ex=:*.sh=:*.txt=:*.log=:*.md=:*.pdf=:*.zip=:*.gz=:*.png=:*.jpg=:*.gif=:*.rb=:*.py=:*.js=:*.go=󰟓:*.pl=:*.pm=:*.ts=:*.css=:*.sql=:db=:*.csv=:*.yaml=:*.yml=:*.toml=:*.json=󰘦:*.html="

export BAT_OPTS="--color=always --style=numbers"
export BAT_THEME="TwoDark"
export BAT_PAGER="less -RiMFX"

((${+commands[brew]})) && export HOMEBREW_PREFIX=$(brew --prefix)

((${+commands[mise]})) > /dev/null 2>&1 && eval "$(mise activate zsh)"
((${+commands[zoxide]})) > /dev/null 2>&1 && eval "$(zoxide init zsh)"

# Prepend homebrew after mise activation so /opt/homebrew/bin/git takes precedence over /usr/bin/git
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $path
)
