set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set smartindent
set smarttab
set fileformat=unix

iab pry from ptpython.repl import embed; embed(globals(), locals())

" Linting is done by NeoMake
let g:pymode_lint = 0
