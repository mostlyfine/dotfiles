set nocompatible

" Vundle -------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'hrp/EnhancedCommentify'
Bundle 'matchit.zip'
Bundle 'vim-scripts/surround.vim'
Bundle 'tpope/vim-endwise'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/Align'
Bundle 'thinca/vim-ref'
Bundle 'vim-scripts/sudo.vim'
Bundle 'tyru/DumbBuf.vim'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'vim-perl/vim-perl'
Bundle 'vim-jp/vimdoc-ja'
Bundle 'mattn/jscomplete-vim'
Bundle 'myhere/vim-nodejs-complete'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/taglist.vim'
Bundle 'rhysd/github-complete.vim'
Bundle 'digitaltoad/vim-pug'
Bundle 'viis/vim-bclose'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'

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
set matchtime=1                     " 括弧ハイライト表示を0.1sで
set number                          " 行番号表示
set display=uhex                    " 印字不可能文字を16進数で表示
set nolist                          " タブや改行文字を表示しない
set noruler                         " ルーラーを表示しない
set formatoptions+=mM               " テキスト挿入中の自動折り返しを日本語に対応
set shellslash                      " ディレクトリの区切り文字に/指定
set nocursorline                    " カーソル行非表示
set wrap                            " ウィンドウ幅より長い行を折り返し表示
set display=lastline                " 長い行を表示する

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
set grepprg=git\ grep\ -n\ $*       " grepにgit grepを使用する
if has('path_extra')
  set tags+=tags;.tags;.git/tags;.git/.tags;~/tags;~/.tags
endif

" backup
set backup                          " バックアップ有効
set backupdir=~/.vim-backup,~/tmp,/tmp,.

" menu / complation
set wildmenu                        " コマンド補完メニューを表示
set wildmode=full                   " 複数のマッチがあるときは全てのマッチを表示し、共通する最長の文字列まで補完
set history=1000                    " コマンドの履歴数
set complete+=k                     " 補完に辞書ファイル追加
set pumheight=10                    " 補完メニューの最大高さ指定

" help
set helplang=ja,en                  " ヘルプの検索順序

" color
set t_Co=256
colorscheme xoria256
set background=light
"colorscheme solarized
"let g:solarized_visibility="high"
"let g:solarized_contrast="high"

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
nnoremap <C-g> :<C-v>vimgrep<Space>/<C-r><C-w>/j<Space>

" visual選択を*検索
vnoremap * "zy:let @/ = @z<CR>n

" make
nnoremap <Leader>m <ESC>:make<CR>

" コマンド履歴の暴発を防ぐ
nnoremap <F5> <CR>q:
nnoremap q: <NOP>

" 行末までヤンク
nnoremap Y y$

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

" swapファイルが有る場合は自動的にread onlyで開く
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END

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
autocmd BufNewFile,BufRead *.js,*.es6 setlocal filetype=javascript fileencoding=utf-8
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" perl
autocmd BufNewFile,BufRead *.pl,*.pm,*.t,*.cgi,*.psgi,cpanfile setlocal filetype=perl
autocmd BufNewFile,BufRead *.tt,*.tt2 setlocal filetype=tt2html
autocmd FileType perl setlocal path+=./;./lib
let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250

" ruby
autocmd BufNewFile,BufRead *.rb,*.feature,*.haml setlocal filetype=ruby
let ruby_space_errors=1

" coffeescript
autocmd BufRead,BufNewFile,BufReadPre *.coffee setlocal filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et " インデント設定
"autocmd BufWritePost *.coffee silent make!          " 保存と同時にコンパイルする
"autocmd QuickFixCmdPost * nested cwindow | redraw!  "エラーがあったら別ウィンドウで表示
"nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する

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

" plugin ------------------------------------------------------------

" vim-ruby.vim
let g:rubycomplete_buffer_loading=1     " rubyのomni補完を設定
let g:rubycomplete_classes_in_global=1  " global classもomni補完
let g:rubycomplete_rails=1              " railsのメソッド名もomni補完

" git-commit.vim
let git_diff_spawn_mode=1               " windowを横に分割

" YankRing.vim
let g:yankring_history_dir = $HOME.'/.vim'
let g:yankring_history_file = '.yankring_history'

" neocomplcache
let g:neocomplcache_enable_at_startup=1             " neocomplcache有効化
let g:neocomplcache_enable_smart_case=1             " 大文字小文字を無視
let g:neocomplcache_enable_camel_case_completion=0  " camel case無効
let g:neocomplcache_enable_underbar_completion=1    " _区切りの補完を有効
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'java' : $HOME.'/.vim/dict/j2se14.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ 'perl' : $HOME.'/.vim/dict/perl.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ }

" neosnippet
let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" ref.vim
let g:ref_perldoc_complete_head = 1

" Dumbbuf
let g:dumbbuf_hotkey = ';;'
let g:dumbbuf_single_key  = 1
let g:dumbbuf_updatetime  = 1    " &updatetimeの最小値
let g:dumbbuf_wrap_cursor = 0
let g:dumbbuf_remove_marked_when_close = 1
let g:dumbbuf_close_when_exec = 1

" ctrlp.vim
nnoremap ff :CtrlPMixed<CR>
nnoremap fm :CtrlPMRUFiles<CR>
nnoremap fb :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-l>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode   = 'ra'
let g:ctrlp_by_filename         = 1 " フルパスではなくファイル名のみで絞込み
let g:ctrlp_jump_to_buffer      = 2 " タブで開かれていた場合はそのタブに切り替える
let g:ctrlp_clear_cache_on_exit = 0 " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 200 " MRUの最大記録数
let g:ctrlp_highlight_match     = [1, 'IncSearch'] " 絞り込みで一致した部分のハイライト
let g:ctrlp_open_new_file       = 1 " 新規ファイル作成時にタブで開く
let g:ctrlp_open_multi          = '10t' " 複数ファイルを開く時にタブで最大10まで開く
set wildignore+=*/tmp/*,*/log/*,*.so,*.swp,*.zip,*.log
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|dat|log|swp|zip)$',
  \ }

" vim-javascript.vim
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" jscomplete.vim
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS

" bclose.vim
nnoremap <silent> <Leader>bd :Bclose<CR>
command! Bc Bclose

" nodejscomplete
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'

let g:node_usejscomplete = 1

" markdown
let g:markdown_fenced_languages = [
      \  'coffee',
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
