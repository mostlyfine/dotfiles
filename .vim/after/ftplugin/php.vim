compiler php
"
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
setlocal dictionary=$HOME/.vim/dict/php.dict

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0
let php_baselib=1
let sql_type_default='mysql'
