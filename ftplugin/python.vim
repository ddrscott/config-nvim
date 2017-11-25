set tabstop=4
set softtabstop=4
set shiftwidth=4
" set textwidth=79
set expandtab
" set autoindent
set fileformat=unix

iab pry import code; code.interact(local=dict(globals(), **locals()))
