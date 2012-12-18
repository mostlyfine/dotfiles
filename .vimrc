set nocompatible

" Vundle -------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'hrp/EnhancedCommentify'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/surround.vim'
Bundle 'vim-scripts/endwise.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'Shougo/neocomplcache'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/Align'
Bundle 'thinca/vim-ref'
Bundle 'vim-scripts/sudo.vim'
Bundle 'vim-scripts/buftabs'
Bundle 'kien/ctrlp.vim'
Bundle 'teramako/jscomplete-vim'
Bundle 'vim-perl/vim-perl'
Bundle 'vim-jp/vimdoc-ja'

filetype plugin indent on

" basic -------------------------------------------------------------

" status line
set laststatus=2                    " 常にステータスラインを表示
set cmdheight=2                     " コマンドラインで利用する行数
set statusline=[%L]\ %t%r%m%=\ [%{&ff}]\ %{'['.(&fenc!=''?&fenc:&enc).']'}\ %c:%l

" edit
set autoread                        " 他で書き換えられたら自動で再読み込み
set hidden                          " 編集中でもほかのファイルを開けるようにする
set backspace=indent,eol,start      " バックスペースでインデントや改行を削除
set confirm                         " 変更バッファを保存するか確認
set pastetoggle=<F12>               " F12で'paste'と'nopaste'を切り替える

" display
syntax on
set title                           " ウィンドウのタイトルを変更する
set scrolloff=5                     " スクロール時の余白確保
set vb t_vb=                        " ビープを鳴らさない
set showcmd                         " コマンドをステータス行に表示
set showmatch                       " 括弧の対応をハイライト
set number                          " 行番号表示
set display=uhex                    " 印字不可能文字を16進数で表示
set nolist                          " タブや改行文字を表示しない
set noruler                         " ルーラーを表示しない
set formatoptions+=mM               " テキスト挿入中の自動折り返しを日本語に対応
set shellslash                      " ディレクトリの区切り文字に/指定

" indent
set autoindent                      " 自動的にインデントする
set smartindent                     " 新規行に対して自動でインデントする
set tabstop=2                       " タブの画面上での幅
set shiftwidth=2
set expandtab                       " タブをスペースに展開する
set smarttab                        " 行頭の余白でタブを押すとshiftwidthだけインデントする

" encoding
set termencoding=utf-8              " ターミナルで使われるエンコーディング
set encoding=utf-8                  " デフォルトエンコーディング
set fileencoding=utf-8              " デフォルトのファイルエンコーディング
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932 " vimが表示できるエンコードのリスト
set fileformats=unix,mac,dos        " ファイルの改行タイプ指定

set ambiwidth=double                " ASCIIと同じ文字幅

" search
set wrapscan                        " 検索で最終行まで行ったら先頭に戻る
set ignorecase                      " 大文字小文字無視
set smartcase                       " 大文字ではじめたら大文字小文字無視しない
set incsearch                       " インクリメンタルサーチ
set hlsearch                        " 検索文字をハイライト
set grepprg=git\ grep\ -n\ $*       " grepにgit grepを使用する

" backup
set backup                          " バックアップ有効
set backupdir=~/.vim-backup,~/tmp,/tmp,.

" menu / complation
set wildmenu                        " コマンド補完メニューを表示
set wildmode=full                   " 複数のマッチがあるときは全てのマッチを表示し、共通する最長の文字列まで補完
set history=1000                    " コマンドの履歴数
set complete+=k                     " 補完に辞書ファイル追加

" help
set helplang=ja,en                  " ヘルプの検索順序

" color
set t_Co=256
colorscheme xoria256

" keybind ----------------------------------------------------------
imap <C-j> <Esc>

" 行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 検索語を画面中央に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" 検索文字のハイライト/アンハイライト
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#

" window操作
nnoremap + 3<C-w>+
nnoremap - 3<C-w>-
nnoremap { 3<C-w><
nnoremap } 3<C-w>>

" バッファ移動
nnoremap <Space> :bn<CR>
nnoremap <S-Space> :bp<CR>
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>
nnoremap <Down> :ls<CR>
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
nnoremap <F4> :ls<CR>

" カーソルを一個左に戻す
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>

" カーソル下のキーワードをヘルプで引く
nnoremap <C-h> :<C-v>help<Space><C-r><C-w><Enter>

" カーソル下のキーワードをgrepする
nnoremap <C-g> :<C-v>vimgrep<Space>/<C-r><C-w>/j<Space>

" make
nnoremap <Leader>m <ESC>:make<CR>

" command -----------------------------------------------------------

" changelog grep
command! -nargs=1 ChangeLogGrep vimgrep /<args>/j ~/changelog | cw

" ファイルエンコーディング指定再読み込み
command! Cp932 edit ++enc=cp932
command! Utf8 edit ++enc=utf-8
command! Euc edit ++enc=euc-jp

" cdpathを考慮した引数補完
command! -complete=customlist, CompleteCD -nargs=? CD cd <args>
function! CompleteCD(arglead, cmdline, cursorpos)
  let pat = join(split(a:cmdline, '\s', !0)[1:], ' '), '*/'
  return split(globpath(&cdpath, pat), "\n")
endfunction

" filetype ----------------------------------------------------------

filetype on
filetype indent on  " ファイルタイプによるインデント設定
filetype plugin on  " ファイルタイプごとのプラグイン読み込み

" changelog
autocmd BufNewFile,BufNew,BufRead *.changelog,changelog setlocal filetype=changelog
let g:changelog_timeformat="%Y-%m-%d"
let g:changelog_username="mostlyfine@gmail.com"

" git
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal filetype=git

" yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" html
autocmd BufNewFile,BufRead *.tt,*.cfm setlocal filetype=html
autocmd FileType html :setlocal includeexpr=substitute(v:fname,'^\\/','','')

" perl
autocmd BufNewFile,BufRead *.pl,*.pm,*.t,*.cgi,*.psgi setlocal filetype=perl
autocmd FileType perl setlocal path+=./;./lib
let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250

" ruby
autocmd BufNewFile,BufRead *.rb,*.feature,*.haml setlocal filetype=ruby
let ruby_space_errors=1

" other -------------------------------------------------------------

" 挿入モード時、pasteオプションを解除する
autocmd InsertLeave * set nopaste

" 挿入モード時ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermbg=red guibg=red
autocmd InsertLeave * highlight StatusLine ctermbg=darkgray guibg=darkgray

" 自動的にQuickFixリストを表示する
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickFixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin

" 全角/行末スペースを表示
scriptencoding utf-8
highlight IgnoreSpace ctermbg=red guibg=red
autocmd Colorscheme * highlight IgnoreSpace ctermbg=red guibg=red
autocmd VimEnter,WinEnter * match IgnoreSpace /\s\+$\|　/

" template ------------------------------------------------------------
autocmd BufNewFile *.html 0r ~/.vim/templates/html.tpl
autocmd BufNewFile *.pl,*.pm 0r ~/.vim/templates/perl.tpl
autocmd BufNewFile *.rb 0r ~/.vim/templates/ruby.tpl

" plugin ------------------------------------------------------------

" vim-ruby.vim
let g:rubycomplete_buffer_loading=1     " rubyのomni補完を設定
let g:rubycomplete_classes_in_global=1  " global classもomni補完
let g:rubycomplete_rails=1              " railsのメソッド名もomni補完

" git-commit.vim
let git_diff_spawn_mode=1               " windowを横に分割

" neocomplcache
let g:neocomplcache_enable_at_startup=1             " neocomplcache有効化
let g:neocomplcache_enable_smart_case=1             " 大文字小文字を無視
let g:neocomplcache_enable_camel_case_completion=0  " camel case無効
let g:neocomplcache_enable_underbar_completion=1    " _区切りの補完を有効
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'java' : $HOME.'/.vim/dict/j2se14.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ 'perl' : $HOME.'/.vim/dict/perl.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ }


" ref.vim
let g:ref_perldoc_complete_head = 1

" buftabs.vim
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1
let g:buftabs_active_highlight_group="Visual"

" ctrlp.vim
nnoremap ff :CtrlP<CR>
nnoremap fb :CtrlPBuffer<CR>
nnoremap fm :CtrlPMRUFiles<CR>
let g:ctrlp_map = '<c-l>'
let g:ctrlp_by_filename         = 1 " フルパスではなくファイル名のみで絞込み
let g:ctrlp_jump_to_buffer      = 2 " タブで開かれていた場合はそのタブに切り替える
let g:ctrlp_clear_cache_on_exit = 0 " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 200 " MRUの最大記録数
let g:ctrlp_highlight_match     = [1, 'IncSearch'] " 絞り込みで一致した部分のハイライト
let g:ctrlp_open_new_file       = 1 " 新規ファイル作成時にタブで開く
let g:ctrlp_open_multi          = '10t' " 複数ファイルを開く時にタブで最大10まで開く
