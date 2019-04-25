umask 002

# path
path=(
  ~/bin(N-/)
  ~/.anyenv/bin(N-/)
  $path
)

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
PROMPT="%% "
RPROMPT="[%1(v|%F{green}%1v%f|):%/]"              # 右プロンプトに情報を表示するときの環境変数

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
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit; compinit -u                 # 補完を有効
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
export LESS="-RiM"
export LESSCHARSET=utf-8
export PAGER="less"

type lv > /dev/null 2>&1 && export PAGER="lv"

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
alias diff="diff -Bbiwu --strip-trailing-cr"

if ! type aws > /dev/null 2>&1; then
  alias aws='docker run --rm -i -v ~/.aws:/root/.aws mesosphere/aws-cli'
fi

# tool
if type keychain > /dev/null 2>&1; then
  keychain -q  ~/.ssh/id_rsa ~/.ssh/id_rsa.hobo > /dev/null 2>&1
  source ~/.keychain/$HOST-sh
fi

[ -e ~/.anyenv ] && eval "$(anyenv init -)"
type hub > /dev/null 2>&1 && eval "$(hub alias -s)"
type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# bindkey
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^X^F' forward-word
bindkey '^X^B' backward-word
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# function
function peco-src () {
  local selected_dir=$(ghq root)/$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-src
bindkey '^]' peco-src

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac=tac
  else
    tac='tail -r'
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N peco-select-history
bindkey '^R' peco-select-history

function peco-ssh () {
  local selected_host=$(grep -iE '^host\s+(\w|\d)+' ~/.ssh/config | awk '{print $2}' | peco --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-ssh
bindkey '^O' peco-ssh
