if exists("current_compiler")
  finish
endif
let current_compiler = "python"

let s:cpo_save = &cpo
set cpo-=C

setlocal tabstop=4 shiftwidth=4 softtabstop=4
setlocal dictionary=$HOME/.vim/dict/python3.5.dict
if has('python')
  setlocal omnifunc=pythoncomplete#Complete
endif
if has('python3')
  setlocal omnifunc=python3complete#Complete
endif

setlocal makeprg=python\ -c\ \"import\ py_compile;\ py_compile.compile(r'%')\"

setlocal errorformat=
	\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
	\%C\ \ \ \ %.%#,
	\%+Z%.%#Error\:\ %.%#,
	\%A\ \ File\ \"%f\"\\\,\ line\ %l,
	\%+C\ \ %.%#,
	\%-C%p^,
	\%Z%m,
	\%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
