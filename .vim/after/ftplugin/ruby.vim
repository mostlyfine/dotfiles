compiler ruby

setlocal tabstop=2 shiftwidth=2 softtabstop=2
setlocal dictionary=$HOME/.vim/dict/ruby.dict
setlocal makeprg=ruby\ -c\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
setlocal path+=./;./vendor/bundle;~/vendor/bundle
setlocal formatoptions-=ro
setlocal omnifunc=rubycomplete#Complete

let ruby_space_errors=1

