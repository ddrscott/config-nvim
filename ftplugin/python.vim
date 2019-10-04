set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set smartindent
set smarttab
set fileformat=unix

" `pry` will expand to Python's version of it.
iab <buffer> pry from ptpython.repl import embed; embed(globals(), locals())
iab <buffer> ipdb import ipdb; ipdb.set_trace()

" Setup for ALE
let b:ale_fixers = ['black']
let b:ale_linters = ['pyls']
call ale#Set('python_black_options', '--line-length=120')

