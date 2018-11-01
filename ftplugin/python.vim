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
let g:neomake_python_enabled_makers = ['flake8']
let g:pymode_lint = 0

autocmd FileType python setlocal omnifunc=RopeCompleteFunc
