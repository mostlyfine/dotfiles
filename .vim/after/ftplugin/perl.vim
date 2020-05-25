compiler perl

setlocal isk+=:
setlocal dictionary=$HOME/.vim/dict/perl.dict
setlocal path+=./;./lib;./local
setlocal formatoptions-=ro

let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250
