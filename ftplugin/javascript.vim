augroup javascript_vim
  au!
  if exists('JsPreTmpl') > 0
    JsPreTmpl
  endif
augroup END

let b:ale_fixers = ['prettier']
let b:ale_linters = ['eslint']
"nnoremap <buffer> <C-]> :ALEGoToDefinition<cr>
"nnoremap <buffer> <Leader>r :ALEFindReferences<cr>

" `pry` will expand to Python's version of it.
iab <buffer> pry debugger; // eslint-disable-line

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set smartindent
set smarttab
