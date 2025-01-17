umask 002

# path
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
)

if [ "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]; then
  ln -snf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
  export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
fi

# color
autoload -Uz colors; colors
export CLICOLOR=true
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# prompt
unsetopt promptcr
setopt prompt_subst                               # 右プロンプトに表示
setopt prompt_percent                             # PROMPT内で「%」文字から始まる置換機能を有効にする。
setopt transient_rprompt                          # コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt nonomatch                                  # 特殊文字を扱わないように

autoload -Uz vcs_info                             # vcs_infoを読み込み

zstyle ':vcs_info:git:*:-all-' command =git       # vcs_infoでのgitを本物のgitを利用する。
zstyle ':vcs_info:*' formats '%s:%b%c%u'          # vcs_info_msg_0_変数をどのように表示するかフォーマットの指定
zstyle ':vcs_info:*' actionformats '%s:%b|%a%c%u' # 特別な状態（mergeでコンフリクトしたときなど）でのフォーマット
zstyle ':vcs_info:*' unstagedstr '*'              # display * if there are unstaged changes
zstyle ':vcs_info:*' stagedstr '+'                # display + if there are staged changes

precmd () {                                       # precmd: プロンプトが表示される毎に実行される関数
  psvar=()
  vcs_info                                        # バージョン管理システムから情報を取得
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_" # vcs_info_msg_0_: バージョン管理システムの情報
}
PROMPT="[%F{magenta}%m%f]%# "
RPROMPT="[%1(v|%F{green}%1v%f|):%(5~,%-1~/.../%2~,%~)]" # 右プロンプトに情報を表示するときの環境変数

# history
setopt extended_history                           # ヒストリファイルにコマンドラインだけでなく実行時刻を保存
setopt hist_expand                                # 補完時にヒストリを自動的に展開する。
setopt hist_ignore_dups                           # 同じコマンドラインを連続で実行した場合はヒストリに登録しない
setopt hist_ignore_all_dups                       # 履歴に加えられる新しいコマンドが古いものと重複している場合、古いものを削除
setopt hist_reduce_blanks                         # ヒストリに保存する時に余分な空白を削除して保存
setopt hist_save_no_dups                          # 古いコマンドと同じものは無視
setopt hist_no_store                              # historyコマンドをヒストリリストから除外
setopt hist_ignore_space                          # スペースで始まるコマンドラインはヒストリに追加しない
setopt share_history                              # zshプロセス間でヒストリを共有する
setopt inc_append_history                         # すぐにヒストリファイルに追記する
setopt no_flow_control                            # 出力停止、開始用にC-s/C-qを使わない

HISTFILE=$HOME/.zhistory                          # ヒストリ保存ファイル
HISTSIZE=100000                                   # メモリ上のヒストリ数
SAVEHIST=$HISTSIZE                                # 保存するヒストリ数

# completion
if type brew &>/dev/null; then
  fpath=(
    $(brew --prefix)/share/zsh/site-functions(N-/)
    $(brew --prefix)/share/zsh-completions(N-/)
    $(brew --prefix git)/share/zsh/site-functions(N-/)
    $fpath
  )
  if [ -e $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi
else
  fpath=(
    ~/.zsh/completions(N-/)
    $fpath
  )
fi

if type go &>/dev/null; then
  path=($path $(go env GOPATH)/bin(N-/))
  export GOROOT=$(go env GOROOT)
  export GOPATH=$(go env GOPATH)
fi

_compinit() {
  local re_initialize=0
  for match in ~/.zcompdump*(.Nmh+24); do
    re_initialize=1
    break
  done

  autoload -Uz compinit
  if [ "$re_initialize" -eq "1" ]; then
    compinit
    compdump
  else
    compinit -C
  fi
}

_compinit                                         # 補完を有効
setopt auto_list                                  # 補完時にリストを表示
setopt auto_menu                                  # 連続した補完実行でメニュー補完
setopt list_packed                                # 補完候補リストをできるだけコンパクトに
setopt list_types                                 # 補完候補の末尾にファイルタイプマークを表示
setopt print_eight_bit                            # 標準出力時8bitコードを表示
setopt complete_in_word                           # 語の途中でもカーソル位置で補完
setopt mark_dirs                                  # ディレクトリの表示時末尾に/
setopt auto_param_slash                           # 補完された変数がディレクトリの時、スラッシュを末尾に付加
setopt auto_param_keys                            # 変数名の補完が実行されると後に空白などが挿入
setopt magic_equal_subst                          # = 以降も補完
setopt correct                                    # スペルチェック。間違うと訂正してくれる
setopt numeric_glob_sort                          # 辞書順ではなく数字順に並べる。

zstyle ':completion:*:default' menu select=1      # 補完候補を選択
zstyle ':completion:*' use-cache yes              # 補完候補をキャッシュする
zstyle ':completion:*' verbose no                 # 補完に詳細な情報を表示しない
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # ファイルリスト補完時に全角半角無視
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 補完候補に色付け

# directory
setopt auto_cd                                    # ディレクトリ名だけでcdする
setopt auto_pushd                                 # cdで移動してもpushdと同じようにディレクトリスタックに追加
setopt pushd_ignore_dups                          # ディレクトリスタックに、同じディレクトリを入れない

# option
typeset -U path cdpath fpath manpath              # 重複する要素を削除
setopt ignore_eof                                 # ^Dでログアウトできるようにする。
setopt interactive_comments                       # コマンドラインでも# 以降をコメントと見なす
setopt short_loops                                # 制御構文で短縮形を使用する
setopt nobeep                                     # ビープ音を鳴らさない

# environment
export LANG=ja_JP.UTF-8
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'         # 単語区切り文字
export REPORTTIME=3                               # 3秒以上かかった処理は詳細表示
export EDITOR=vim
export CTAGS="-Rh"
export LV="-c -l"
export LESS="-RiMFX"
export LESSCHARSET=utf-8
export PAGER="less"
export DIFF_OPTIONS="-uiBw --strip-trailing-cr"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --select-1 --exit-0"
export BAT_THEME="TwoDark"
export BAT_STYLE="numbers,changes"
export RIPGREP_CONFIG_PATH=$HOME/dotfiles/.ripgreprc

((${+commands[lv]})) && export PAGER="lv"
((${+commands[colordiff]})) && alias diff="colordiff"

# alias
case "${OSTYPE}" in
  linux*)
    alias ls="ls --color=auto -Fh"
    ;;
  *)
    alias ls="ls -Gw"
    ;;
esac

alias ll="ls -lth"
alias g="git"
alias vi="vim"
alias grep="grep -I"
alias -g DPS='`docker ps -a | tail -n +2 | fzf | cut -d" " -f1`'
alias -g PROD='`aws production | fzf | cut -f2`'
alias -g PERFORM='`aws perform | fzf | cut -f2`'
alias -g HOSTS='`grep -iE "^host\s+(\w|\d)+" ~/.ssh/config | cut -d" " -f2 | fzf`'

# tool
if [ -f ~/.keychain/$(hostname)-sh -a ((${+commands[keychain]})) ];then
  keychain -q ~/.ssh/id_ed25519 ~/.ssh/id_rsa > /dev/null 2>&1
  source ~/.keychain/$(hostname)-sh
fi

((${+commands[hub]})) > /dev/null 2>&1 && eval "$(hub alias -s)"
((${+commands[direnv]})) > /dev/null 2>&1 && eval "$(direnv hook zsh)"

if [ -e ~/google-cloud-sdk ]; then
  source ~/google-cloud-sdk/path.zsh.inc
  source ~/google-cloud-sdk/completion.zsh.inc
fi

if type mise &>/dev/null; then
  eval "$(mise activate zsh)"
  eval "$(mise activate --shims)"
fi

if type kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  alias kc="kubectl"
fi

# bindkey
bindkey -e
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^X^F' forward-word
bindkey '^X^B' backward-word
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# function
function fzf-ghq() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER" --preview "cat {}/READ*.*")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}

zle -N fzf-ghq
bindkey '^]' fzf-ghq

function fzf-select-history() {
  BUFFER=$(fc -lnr 1 | fzf -e --no-sort --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}

zle -N fzf-select-history
bindkey '^R' fzf-select-history

function fzf-ssh () {
  local selected_host=$(grep -iE '^host\s+(\w|\d)+' ~/.ssh/config | awk '{print $2}' | fzf --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle reset-prompt
}

zle -N fzf-ssh
bindkey '^O' fzf-ssh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ~/.zshenv
# export ZDOTDIR=$HOME/dotfiles
[ -f ${ZDOTDIR:-~}/.zshrc_local ] && source ${ZDOTDIR:-~}/.zshrc_local

