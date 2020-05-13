compiler php

autocmd BufNewFile,BufRead *.ctp,*.thml setlocal filetype=php
"
" config -----------------------------------------------------------
set formatoptions-=r
set formatoptions-=o
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
set dictionary=$HOME/.vim/dict/php.dict

" variables --------------------------------------------------------
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0
