if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim-plug
call plug#begin('~/.vim/plugged')
Plug 'guns/jellyx.vim'         " colorscheme
Plug 'tyru/caw.vim'            " 行選択コメントアウト
Plug 'tmhedberg/matchit'       " %ブレース対応拡張
Plug 'tpope/vim-surround'      " カッコ処理拡張
Plug 'LeafCage/yankround.vim'  " yank履歴管理
Plug 'junegunn/vim-easy-align' " テキスト整形
Plug 'tyru/DumbBuf.vim'        " 軽量バッファマネージャ
Plug 'ctrlpvim/ctrlp.vim'      " 多機能セレクタ
Plug 'vim-jp/vimdoc-ja'        " 日本語ドキュメント
Plug 'yegappan/taglist'        " 関数一覧表示
Plug 'tpope/vim-fugitive'      " gitラッパー
Plug 'itchyny/lightline.vim'   " カスタムステータスライン
Plug 'thinca/vim-quickrun'     " quick run
Plug 'thinca/vim-template'     " template

Plug 'tpope/vim-markdown',         { 'for': 'markdown' }
Plug 'pangloss/vim-javascript',    { 'for': ['javascript', 'typecript'] }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'maxmellon/vim-jsx-pretty',   { 'for': ['javascript', 'typescript', 'jsx'] }
Plug 'ekalinin/Dockerfile.vim',    { 'for': 'Dockerfile' }
Plug 'fatih/vim-go',               { 'for': 'go', 'do': ':GoUpdateBinaries' }

" Python
"if has('python3') && system('pip3 show jedi') !=# ''
"  Plug 'davidhalter/jedi-vim',     { 'for': 'python' }
"endif

" ファイラ
if v:version >= 800
  Plug 'cocopon/vaffle.vim'
elseif has('conceal')
  Plug 'justinmk/vim-dirvish'
  let g:dirvish_mode = 2
endif

" 補完
" if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  let g:deoplete#enable_at_startup = 1
" elseif v:version >= 800 && has('timers') && has('python3')
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"  let g:deoplete#enable_at_startup = 1
if v:version >= 703 && has('lua')
  Plug 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 20
  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_auto_select = 0
  let g:neocomplete#lock_buffer_name_pattern = ''
  let g:neocomplete#enable_fuzzy_completion = 0
  inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
else
  Plug 'Shougo/neocomplcache'
  let g:neocomplcache_enable_at_startup=1             " neocomplcache有効化
  let g:neocomplcache_enable_smart_case=1             " 大文字小文字を無視
  let g:neocomplcache_enable_camel_case_completion=0  " camel case無効
  let g:neocomplcache_enable_underbar_completion=1    " _区切りの補完を有効
  let g:neocomplcache_enable_auto_select = 0
  let g:neocomplcache_min_syntax_length=3
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'java' : $HOME.'/.vim/dict/j2se14.dict',
      \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
      \ 'perl' : $HOME.'/.vim/dict/perl.dict',
      \ 'php' : $HOME.'/.vim/dict/php.dict',
      \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
      \ 'python': $HOME.'/.vim/dict/python3.5.dict',
      \ }
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*' "日本語を補完候補として取得しない
  inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endif

" スニペット
if v:version > 702
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
  imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
endif

call plug#end()

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
set gdefault                        " 置換の際のgオプションをデフォルトで有効化

" display
syntax on
set notitle                         " ウィンドウのタイトルを変更する
set scrolloff=5                     " スクロール時の余白確保
set t_vb=                           " ビープを鳴らさない
set novisualbell                    "
set noerrorbells                    "
set showcmd                         " コマンドをステータス行に表示
set showmatch                       " 括弧の対応をハイライト
set matchtime=1                     " 括弧ハイライト表示を0.1sで
set number                          " 行番号表示
set nolist                          " タブや改行文字を表示しない
set noruler                         " ルーラーを表示しない
set formatoptions+=mM               " テキスト挿入中の自動折り返しを日本語に対応
set shellslash                      " ディレクトリの区切り文字に/指定
set nocursorline                    " カーソル行非表示
set wrap                            " ウィンドウ幅より長い行を折り返し表示
set display=lastline                " 長い行を表示する
set nofoldenable                    " 折りたたみをすべて展開

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

" japanese
set ambiwidth=double                " ASCIIと同じ文字幅
set imdisable                       " ノーマルモードに戻った時に日本語入力をOFF

" search
set wrapscan                        " 検索で最終行まで行ったら先頭に戻る
set ignorecase                      " 大文字小文字無視
set smartcase                       " 大文字ではじめたら大文字小文字無視しない
set incsearch                       " インクリメンタルサーチ
set hlsearch                        " 検索文字をハイライト
set grepprg=git\ grep\ -iwn\ $*     " grepにgit grepを使用する
if has('path_extra')
  set tags+=tags;.tags;.git/tags;.git/.tags;~/tags;~/.tags
endif

" backup
if isdirectory(expand('~/.vim-backup'))
  set backup
  set backupdir=~/.vim-backup
else
  set nobackup
endif

" menu / complation
set wildmenu                        " コマンド補完メニューを表示
set wildmode=full                   " 複数のマッチがあるときは全てのマッチを表示し、共通する最長の文字列まで補完
set history=1000                    " コマンドの履歴数
set complete=.,w,b,u,t,k            " 補完に辞書ファイル追加
set pumheight=10                    " 補完メニューの最大高さ指定
set completeopt=menuone,noselect,noinsert    " 補完候補が１つでも表示、自動選択不可、自動挿入不可


" help
set helplang=ja,en                  " ヘルプの検索順序

" color
set t_Co=256
set background=dark
colorscheme jellyx

" keybind ----------------------------------------------------------
inoremap <silent> jj <Esc>
inoremap <C-j> <Esc>
noremap <C-j> <esc>
noremap! <C-j> <esc>

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
nmap <Space> <Esc>:bn<CR>
nmap <S-Space> <Esc>:bp<CR>
nmap <Left> <Esc>:bp<CR>
nmap <Right> <Esc>:bn<CR>
nmap <Down> <Esc>:ls<CR>
nmap <F2> <Esc>:bprevious<CR>
nmap <F3> <Esc>:bnext<CR>
nmap <F4> <Esc>:ls<CR>

" カーソルを一個左に戻す
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap <> <><Left>
"inoremap ' ''<Left>
"inoremap " ""<Left>

" コマンドラインモードでEmacキーバインド移動
cnoremap <C-f>  <Right>
cnoremap <C-b>  <Left>
cnoremap <C-a>  <C-b>
cnoremap <C-e>  <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" カーソル下のキーワードをヘルプで引く
nnoremap <C-h> :<C-v>help<Space><C-r><C-w><Enter>

" カーソル下のキーワードをgrepする
nnoremap <C-g> :silent <C-v>grep<Space><Space><C-r><C-w><CR>

" visual選択を*検索
vnoremap * "zy:let @/ = @z<CR>n

" make
nnoremap <Leader>m <ESC>:make<CR>

" コマンド履歴の暴発を防ぐ
nnoremap <F5> <CR>q:
nnoremap q: <NOP>
nnoremap q/ <NOP>
nnoremap q? <NOP>

" 行末までヤンク
nnoremap Y y$

" sudo write
cmap w!! w !sudo tee &gt; /dev/null %

" command -----------------------------------------------------------

" changelog grep
command! -nargs=1 Grep vimgrep /<args>/j % | cw

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

" swapファイルが有る場合は自動的にread onlyで開く
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END

" インサートモードに入る時に自動でコメントアウトされないようにする
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" filetype ----------------------------------------------------------

filetype on
filetype indent on  " ファイルタイプによるインデント設定
filetype plugin on  " ファイルタイプごとのプラグイン読み込み

" changelog
autocmd BufNewFile,BufNew,BufRead *.changelog,changelog setlocal filetype=changelog
let g:changelog_timeformat="%Y-%m-%d"
let g:changelog_username="mostlyfine@gmail.com"

" yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" html
autocmd BufNewFile,BufRead *.cfm,*.tx setlocal filetype=html
autocmd FileType html :setlocal includeexpr=substitute(v:fname,'^\\/','','')
autocmd FileType html :compiler tidy
autocmd FileType html :setlocal makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ \"%\"

" javascript
autocmd BufNewFile,BufRead *.js,*.es6,ts,tsx setlocal filetype=javascript fileencoding=utf-8
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" perl
autocmd BufNewFile,BufRead *.pl,*.pm,*.t,*.cgi,*.psgi,cpanfile setlocal filetype=perl
autocmd BufNewFile,BufRead *.tt,*.tt2 setlocal filetype=tt2html
autocmd FileType perl setlocal path+=./;./lib;./local
let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250

" ruby
autocmd BufNewFile,BufRead *.rb,*.feature,*.haml setlocal filetype=ruby
autocmd FileType ruby setlocal path+=./;./vendor/bundle;~/vendor/bundle
let ruby_space_errors=1

" php
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1

" sql
let g:sql_type_default = 'mysql'

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
augroup AdditionalHighlights
  autocmd!
  highlight IgnoreSpace ctermbg=red guibg=red
  autocmd Colorscheme * highlight IgnoreSpace ctermbg=red guibg=red
  autocmd VimEnter,WinEnter * match IgnoreSpace /\s\+$\|　/
augroup END

" plugin ------------------------------------------------------------

" Dumbbuf
let g:dumbbuf_hotkey = ';;'
let g:dumbbuf_single_key  = 1
let g:dumbbuf_updatetime  = 1    " &updatetimeの最小値
let g:dumbbuf_wrap_cursor = 0
let g:dumbbuf_remove_marked_when_close = 1
let g:dumbbuf_close_when_exec = 1

" vim-markdown
let g:markdown_fenced_languages = [
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'perl',
      \  'sql',
      \  'html',
      \  'xml',
      \]

" ctrlp.vim
nnoremap ff :CtrlPMixed<CR>
nnoremap fm :CtrlPMRUFiles<CR>
nnoremap fb :CtrlPBuffer<CR>
nnoremap ft :CtrlPTag<CR>
nnoremap fl :CtrlPLine<CR>
nnoremap fp :<C-u>CtrlPYankRound<CR>
let g:ctrlp_map = '<c-l>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode   = 'ra'
let g:ctrlp_by_filename         = 1 " フルパスではなくファイル名のみで絞込み
let g:ctrlp_jump_to_buffer      = 2 " タブで開かれていた場合はそのタブに切り替える
let g:ctrlp_clear_cache_on_exit = 0 " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 200 " MRUの最大記録数
let g:ctrlp_lazy_update         = 1 " 遅延再描画
let g:ctrlp_show_hidden         = 0 " 隠しファイルを表示しない
let g:ctrlp_highlight_match     = [1, 'IncSearch'] " 絞り込みで一致した部分のハイライト
let g:ctrlp_open_new_file       = 1 " 新規ファイル作成時にタブで開く
let g:ctrlp_open_multi          = '10t' " 複数ファイルを開く時にタブで最大10まで開く
set wildignore+=*/tmp/*,*/log/*,*.so,*.swp,*.zip,*.log
" ルートパスと認識させるためのファイル
let g:ctrlp_root_markers = ['Gemfile', 'cpanfile', 'package.json', 'build.xml', 'Procfile', 'Makefile']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|dat|log|swp|zip)$',
  \ }
let g:ctrlp_buffer_func = {'enter': 'CtrlPEnter'}
function! CtrlPEnter()
  let w:lightline = 0
endfunction

" yankround
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" taglist
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_javascript_settings = 'javascript;c:class;m:method;F:function;p:property'
let g:tlist_php_settings        = 'php;n:namespace;c:class;i:interface;t:trait;f:function;d:constant;v:variable'
map <silent> <leader>l :TlistToggle<CR>

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_visible_condition': {
      \   'gitbranch': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" caw
nmap <Leader>x <Plug>(caw:hatpos:toggle)
vmap <Leader>x <Plug>(caw:hatpos:toggle)

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1
let g:go_term_enabled = 1
let g:go_fmt_autosave = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 0

augroup GolangSettings
  autocmd!
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 autowrite
  autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  highlight goErr cterm=bold ctermfg=214
  autocmd VimEnter,WinEnter *.go :match goErr /\<err\>/
augroup END

" quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config = {
      \ '_': {
      \   'hook/time/enable': 1,
      \   'outputter/error/success':'quickfix output',
      \   'outputter/error/error':  'quickfix',
      \   'outputter/buffer/split': ':rightbelow 8sp',
      \   'outputter/buffer/close_on_empty': 1,
      \ },
      \ 'perl': {
      \   'command': 'perl',
      \   'cmdopt': '-Ilib',
      \   'exec': 'carton exec %c %o %s',
      \ },
      \ 'ruby': {
      \   'command': 'ruby',
      \   'exec': 'bundle exec %c %o %s',
      \ }
      \ }
au FileType qf nnoremap <silent><buffer>q :quit<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)
xmap <Leader>t <Plug>(EasyAlign)
nmap <Leader>t <Plug>(EasyAlign)
vmap <Leader>t <Plug>(EasyAlign)
