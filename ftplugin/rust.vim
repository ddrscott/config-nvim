augroup rust_vim
  au FileType rust nmap <silent> <C-]> <Plug>(rust-def)
  au FileType rust nmap <silent> <C-w><C-]> <Plug>(rust-def-vertical)
  au FileType rust nmap <silent> <C-w>} <Plug>(rust-def-split)
  au FileType rust nmap <silent> <C-k> <Plug>(rust-doc)
  nmap <f8> :RustRun<cr>
augroup END
