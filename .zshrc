bindkey -e
umask 002

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export CLICOLOR=true

# path
typeset -U path
path=(/bin(N-/)
      $HOME/bin(N-/)
      /usr/local/bin(N-/)
      /usr/local/sbin(N-/)
      /usr/bin(N-/)
      /usr/sbin(N-/)
      /sbin(N-/)
)

# sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# alias
if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
  alias lv="less"
fi

export EDITOR=vi
export LV="-c -l"
export LESS="-RiM"
export GIT_MERGE_AUTOEDIT=no

case "${OSTYPE}" in
  linux*)
    alias ls="ls --color=auto -Fh"
    ;;
  *)
    alias ls="ls -Gw"
    ;;
esac

alias diff="diff -Bbiwu --strip-trailing-cr"
alias ll="ls -lth"
alias g="git"
alias r="rails"
alias vi="vim"

# history
setopt extended_history     # ヒストリファイルにコマンドラインだけでなく実行時刻を保存
setopt hist_expand          # 補完時にヒストリを自動的に展開する。
setopt hist_ignore_dups     # 同じコマンドラインを連続で実行した場合はヒストリに登録しない
setopt hist_ignore_all_dups # 履歴に加えられる新しいコマンドが古いものと重複している場合、古いものを削除
setopt hist_reduce_blanks   # ヒストリに保存する時に余分な空白を削除して保存
setopt hist_save_no_dups    # 古いコマンドと同じものは無視
setopt hist_no_store        # historyコマンドをヒストリリストから除外
setopt hist_ignore_space    # スペースで始まるコマンドラインはヒストリに追加しない
setopt share_history        # zshプロセス間でヒストリを共有する
setopt inc_append_history   # すぐにヒストリファイルに追記する
setopt no_flow_control      # 出力停止、開始用にC-s/C-qを使わない

HISTFILE=$HOME/.zhistory    # ヒストリ保存ファイル
HISTSIZE=100000             # メモリ上のヒストリ数
SAVEHIST=$HISTSIZE          # 保存するヒストリ数


# prompt
unsetopt promptcr
setopt prompt_subst       # PROMPT内で変数展開・コマンド置換・算術演算を実行する
setopt prompt_percent     # PROMPT内で「%」文字から始まる置換機能を有効にする。
setopt transient_rprompt  # コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt nonomatch          # 特殊文字を扱わないように

PROMPT="%% "
RPROMPT="[%/]"
PROMPT2="%_%%"
SPROMPT="%r is corrent? [n,y,a,e]: "

autoload -U colors; colors
case "${TERM}" in
  kterm*|xterm*)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=32:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
  cons25)
    unset LANG
    export LSCOLORS=GxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

autoload -Uz vcs_info
zstyle ':vcs_info:git:*:-all-' command /usr/bin/git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:git:*' stagedstr '+'    # display ² if there are staged changes
zstyle ':vcs_info:git:*' formats '%s:%b%c%u'
zstyle ':vcs_info:git:*' actionformats '%s:%b|%a%c%u'
precmd () {
  psvar=()
  vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="[%1(v|%F{green}%1v%f|):%/]"

# completion
autoload -U compinit
compinit -u
setopt auto_list          # 補完時にリストを表示
setopt auto_menu          # 連続した補完実行でメニュー補完
setopt list_packed        # 補完候補リストをできるだけコンパクトに
setopt list_types         # 補完候補の末尾にファイルタイプマークを表示
setopt print_eight_bit    # 標準出力時8bitコードを表示
setopt complete_in_word
setopt mark_dirs          # ディレクトリの表示時末尾に/
setopt auto_param_slash   # 補完された変数がディレクトリであった場合、空白ではなくスラッシュが末尾に付加
setopt auto_param_keys    # 変数名の補完が実行されると後に空白などが挿入
setopt magic_equal_subst  # = 以降も補完

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:(perldoc|perl):*' matcher 'r:|[:][:]=*'


# etc

## direcroty
setopt auto_cd                          #ディレクトリ名だけでcdする
setopt auto_pushd                       #cdで移動してもpushdと同じようにディレクトリスタックに追加
cdpath=(~)                              #移動先検索リスト
chpwd_functions=($chpwd_functions dirs) #ディレクトリが変わったらディレクトリスタックを表示

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
REPORTTIME=3
unsetopt no_unset
setopt nobeep # ビープ音を鳴らさない

setopt extended_glob
setopt numeric_glob_sort
setopt glob_complete
setopt glob_dots
setopt brace_ccl

setopt ignore_eof
setopt pushd_ignore_dups
setopt interactive_comments
setopt long_list_jobs
setopt short_loops
setopt transient_rprompt

setopt no_hup
setopt correct

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# bindkey
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^X^F' forward-word
bindkey '^X^B' backward-word
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


# replace
autoload -U replace-string
zle -N replace-string

# direnv
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)";
fi

# hub
if type hub > /dev/null 2>&1; then
  eval "$(hub alias -s)";
fi

# import
for f (~/dotfiles/zsh.d/*.zsh) source "${f}"
