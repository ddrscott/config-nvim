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

" Setup for ALE
"nnoremap <buffer> <C-]> :exec "norm! m'" <bar> ALEGoToDefinition<cr>
nnoremap <buffer> <C-]> :ALEGoToDefinition<cr>
nnoremap <buffer> <Leader>r :ALEFindReferences<cr>
let b:ale_fixers = ['black']
let b:ale_linters = ['pyls']
