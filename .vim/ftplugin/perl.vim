compiler perl

" config -----------------------------------------------------------
set dictionary=$HOME/.vim/dict/perl_functions.dict

" keybind ----------------------------------------------------------
nnoremap <Leader>pt <ESC>:%! perltidy<CR>
nnoremap <Leader>r <ESC>:!perl %<CR>
vnoremap <Leader>pt <ESC>:'<,'>! perltidy<CR>

" 選択範囲を整形(perl)
vnoremap pt :<C-v>! perltidy<CR>

" [{ で{}の先頭にジャンプ
nnoremap <buffer> <silent> ( :<C-U>call PreviewOpenBrace()<CR>
if !exists('*PreviewOpenBrace')
    function PreviewOpenBrace()
        let l:pos = getpos('.')
        if l:pos == get(s:, 'last_pos', [])
            let l:count = s:last_count + 1
        else
            let l:count = v:count1
        endif
        pclose
        pedit
        wincmd p
        execute 'normal!' l:count . '[{'
        setlocal cursorline
        wincmd p
        let s:last_count = l:count
        let s:last_pos   = l:pos
    endfunction
endif

" variables --------------------------------------------------------
let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250

iab _perls #!/usr/bin/env perl<CR><BS><CR>use strict;<CR>use warnings;<CR>
iab ## # -*- coding: utf-8 -*-
