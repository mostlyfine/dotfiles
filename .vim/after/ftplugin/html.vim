compiler tidy

setlocal includeexpr=substitute(v:fname,'^\\/','','')
setlocal makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ \"%\"
setlocal omnifunc=htmlcomplete#CompleteTags

inoremap <buffer> </ </<C-x><C-o>
inoremap <buffer> </ </<C-x><C-o>
inoremap <> <><Left>
